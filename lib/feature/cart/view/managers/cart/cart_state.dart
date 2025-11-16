part of 'cart_cubit.dart';

abstract class CartState  {
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartItemsResponseModel cart;
  final bool fromCache;

   CartLoaded(this.cart, {required this.fromCache});

}

class CartError extends CartState {
  final String message;

   CartError(this.message);

}
