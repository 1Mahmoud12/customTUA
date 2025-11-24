// change_password_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/network/errors/failures.dart';

import '../../../data/data_source/profile_details_data_source_impl.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ProfileDetailsDataSourceImpl dataSource;

  ChangePasswordCubit(this.dataSource) : super(ChangePasswordInitial());

  /// Controllers for both fields
  final newPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  /// Change password logic
  Future<void> changePassword() async {
    final password = passwordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmNewPasswordController.text.trim();

    if (newPass.isEmpty || confirmPass.isEmpty) {
      emit(ChangePasswordFailure('fill_all_fields'));
      return;
    }
    if (newPass != confirmPass) {
      emit(ChangePasswordFailure('passwords_not_match'));
      return;
    }

    emit(ChangePasswordLoading());

    final Either<Failure, Unit> result = await dataSource.changePassword(password: password, newPassword: newPass, confirmNewPassword: confirmPass);

    result.fold((failure) => emit(ChangePasswordFailure(failure.errMessage)), (_) {
      newPasswordController.clear();
      confirmNewPasswordController.clear();
      emit(ChangePasswordSuccess());
    });
  }

  @override
  Future<void> close() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    return super.close();
  }
}
