part of 'hyper_pay_checkout_cubit.dart';

sealed class HyperPayState {}

final class HyperPayCheckoutInitial extends HyperPayState {}

final class HyperPayLoading extends HyperPayState {}

final class HyperPaySuccess extends HyperPayState {}

final class HyperPayCheckoutError extends HyperPayState {
  final String message;

  HyperPayCheckoutError(this.message);
}
