import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/feature/cart/data/data_source/cart_data_source.dart';
import 'package:tua/feature/cart/data/models/cart_items_response_model.dart';

import '../../../../../core/network/local/hive_data_base.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartDataSource _dataSource;

  CartCubit(this._dataSource) : super(CartInitial());

  CartItemsResponseModel? _cachedCart;

  CartItemsResponseModel? get cachedCart => _cachedCart;

  /// Public method to get cart items
  Future<void> fetchCartItems() async {
    await _loadCachedCart();
    await _fetchCartFromApi();
  }

  /// Load cart from Hive cache first
  Future<void> _loadCachedCart() async {
    emit(CartLoading());
    final box = await openHiveBox('cartBox');
    final cachedJson = box.get('cartCacheKey');

    if (cachedJson != null && cachedJson.isNotEmpty) {
      try {
        _cachedCart = CartItemsResponseModel.fromJson(jsonDecode(cachedJson));
        emit(CartLoaded(_cachedCart!, fromCache: true));
        return;
      } catch (e) {
        emit(CartLoading());
      }
    } else {
      emit(CartLoading());
    }
  }

  /// Fetch fresh cart from API and cache it
  Future<void> _fetchCartFromApi() async {
    final result = await _dataSource.getCartItems();
    result.fold(
      (failure) {
        if (_cachedCart != null) {
          emit(CartLoaded(_cachedCart!, fromCache: true));
        } else {
          emit(CartError(failure.errMessage));
        }
      },
      (cart) async {
        _cachedCart = cart;

        final box = await openHiveBox('cartBox');
        final encoded = jsonEncode(cart.toJson());
        await box.put('cartCacheKey', encoded);

        emit(CartLoaded(cart, fromCache: false));
      },
    );
  }
}
