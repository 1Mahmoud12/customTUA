import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/utils/custom_show_toast.dart';

import '../../../../data/dataSource/reset_password_data_source.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  static ResetPasswordCubit of(BuildContext context) => BlocProvider.of<ResetPasswordCubit>(context);

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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

  Future<void> resetPassword({required BuildContext context}) async {
    emit(ResetPasswordLoading());

    await ResetPasswordDataSource.resetPassword(
      data: {"new_password": newPasswordController.text, "password_confirmation": confirmPasswordController.text},
    ).then((value) {
      value.fold(
        (l) {
          emit(ResetPasswordError(l.errMessage));
          customShowToast(context, l.errMessage, showToastStatus: ShowToastStatus.error);
        },
        (r) {
          emit(ResetPasswordSuccess());
          customShowToast(context, "password_changed");
        },
      );
    });
  }

  @override
  Future<void> close() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
