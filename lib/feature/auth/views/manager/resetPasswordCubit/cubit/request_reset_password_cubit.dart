import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:tua/core/network/errors/failures.dart';

import '../../../../data/dataSource/reset_password_data_source.dart';

part 'request_reset_password_state.dart';

class RequestResetPasswordCubit extends Cubit<RequestResetPasswordState> {
  RequestResetPasswordCubit(this._dataSource) : super(RequestResetPasswordInitial());

final ResetPasswordDataSource _dataSource;

  /// Controller for email input
  final TextEditingController emailController = TextEditingController();

  /// Method to call the API
  Future<void> requestResetPassword() async {
    emit(RequestResetPasswordLoading());
    final Either<Failure, Unit> result = await _dataSource.requestResetPassword(
      email: emailController.text.trim(),
    );

    result.fold(
          (failure) => emit(RequestResetPasswordError(failure.errMessage)),
          (_) => emit(RequestResetPasswordSuccess()),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
