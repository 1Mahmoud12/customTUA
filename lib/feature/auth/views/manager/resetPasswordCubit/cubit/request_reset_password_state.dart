part of 'request_reset_password_cubit.dart';

abstract class RequestResetPasswordState {
  const RequestResetPasswordState();
}

class RequestResetPasswordInitial extends RequestResetPasswordState {}

class RequestResetPasswordLoading extends RequestResetPasswordState {}

class RequestResetPasswordSuccess extends RequestResetPasswordState {}

class RequestResetPasswordError extends RequestResetPasswordState {
  final String message;
  const RequestResetPasswordError(this.message);
}
