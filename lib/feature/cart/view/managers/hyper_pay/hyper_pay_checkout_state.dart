part of 'hyper_pay_checkout_cubit.dart';

sealed class HyperPayState {}

final class HyperPayCheckoutInitial extends HyperPayState {}

final class HyperPayLoading extends HyperPayState {}

final class HyperPaySuccess extends HyperPayState {}

final class HyperPayCheckoutError extends HyperPayState {
  final String message;

  HyperPayCheckoutError(this.message);
}

final class HyperPayConfigLoading extends HyperPayState {}

final class HyperPayConfigLoaded extends HyperPayState {
  final HyperPayConfigData config;

  HyperPayConfigLoaded(this.config);
}

final class HyperPayConfigError extends HyperPayState {
  final String message;

  HyperPayConfigError(this.message);
}

final class HyperPayCheckoutCreated extends HyperPayState {
  final HyperPayCheckoutInner checkoutData;

  HyperPayCheckoutCreated(this.checkoutData);
}
