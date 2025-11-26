part of 'checkout_as_visitor_cubit.dart';

@immutable
abstract class CheckoutAsVisitorState {}

class CheckoutAsVisitorInitial extends CheckoutAsVisitorState {}

class CheckoutAsVisitorLoading extends CheckoutAsVisitorState {}

class CheckoutAsVisitorSuccess extends CheckoutAsVisitorState {}

class CheckoutAsVisitorError extends CheckoutAsVisitorState {
  final String message;
  CheckoutAsVisitorError({required this.message});
}
