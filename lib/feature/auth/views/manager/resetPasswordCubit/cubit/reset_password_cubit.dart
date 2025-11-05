import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/utils/custom_show_toast.dart';

import '../../../../data/dataSource/reset_password_data_source.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._dataSource) : super(ResetPasswordInitial());
  final ResetPasswordDataSource _dataSource;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password_required'.tr();
    }
    if (value.length < 8) {
      return 'password_length'.tr();
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != newPasswordController.text) {
      return 'passwords_do_not_match'.tr();
    }
    return null;
  }

  Future<void> resetPassword({required String otp}) async {
    emit(ResetPasswordLoading());
    final result = await _dataSource.resetPassword(
      password: newPasswordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
      otp: otp,
    );
    result.fold(
      (failure) => emit(ResetPasswordError(failure.errMessage)),
      (success) => emit(ResetPasswordSuccess()),
    );
  }


  @override
  Future<void> close() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
