import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/feature/cart/data/data_source/cart_data_source.dart';
import 'package:tua/feature/cart/data/models/add_cart_item_parms.dart';

import 'add_cart_item_state.dart';

class AddCartItemCubit extends Cubit<AddCartItemState> {
  final CartDataSource _cartDataSource;

  AddCartItemCubit(this._cartDataSource) : super(AddCartItemInitial());

  Future<void> addCartItem(AddCartItemParms params) async {
    if (params.amount == -1) {
      emit(AddCartItemFailure('please_select_an_amount'.tr()));
      return;
    }
    emit(AddCartItemLoading());

    final result = await _cartDataSource.addCartItem(params: params);

    result.fold(
      (failure) => emit(AddCartItemFailure(_mapFailureToMessage(failure))),
      (_) => emit(AddCartItemSuccess()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return failure.errMessage;
    return 'An unexpected error occurred, please try again.';
  }
}
