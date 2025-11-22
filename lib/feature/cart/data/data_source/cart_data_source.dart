import 'package:dartz/dartz.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/feature/cart/data/models/cart_items_response_model.dart';

import '../models/add_cart_item_parms.dart';

abstract class CartDataSource {
  Future<Either<Failure, Unit>> addCartItems({required List<AddCartItemParms> params});
  Future<Either<Failure,CartItemsResponseModel>> getCartItems();
  Future<Either<Failure, Unit>> removeCartItem({required String uniqueKey});
  Future<Either<Failure, Unit>> increaseCartItem({required String itemId});
  Future<Either<Failure, Unit>> decreaseCartItem({required String itemId});
}
