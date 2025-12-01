import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/errorLoadingWidgets/dialog_loading_animation.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/auth/data/dataSource/register_data_source.dart';
import 'package:tua/feature/auth/data/models/register_params.dart';
import 'package:tua/feature/auth/views/presentation/login_view.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit of(BuildContext context) => BlocProvider.of<RegisterCubit>(context);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isTermsConditions = false;

  // selections from lookup
  int? selectedNationalityId;
  int? selectedResidencyId;
  String? selectedGender; // 'Male' | 'Female'

  void setNationality(int id) {
    selectedNationalityId = id;
    emit(ChangeTermsConditionsState());
  }

  void setResidency(int id) {
    selectedResidencyId = id;
    emit(ChangeTermsConditionsState());
  }

  void setGender(String gender) {
    selectedGender = gender;
    emit(ChangeTermsConditionsState());
  }

  void changeTermsConditions() {
    isTermsConditions = !isTermsConditions;
    emit(ChangeTermsConditionsState());
  }

  Future<void> register({required BuildContext context}) async {
    emit(RegisterLoading());
    animationDialogLoading(context);
    await RegisterDataSource.register(
      data: RegisterParams(
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
        firstNameController.text,
        lastNameController.text,
        selectedNationalityId ?? 261,
        selectedResidencyId ?? 261,
        selectedGender ?? 'Male',
        phoneController.text,
      ),
    ).then((value) {
      closeDialog(context);
      value.fold(
        (l) {
          emit(RegisterError(e: l.errMessage));

          log('register errors==> ${l.errMessage}');
          customShowToast(context, l.errMessage, showToastStatus: ShowToastStatus.error);
        },
        (r) async {
          // ConstantsModels.loginModel = r;
          // await userCache?.put(userCacheKey, jsonEncode(r.toJson()));
          // await DioHelper.init();
          context.navigateToPageWithReplacement(const LoginView());

          emit(RegisterSuccess());

          customShowToast(context, 'account_created_success'.tr());
        },
      );
    });
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    organizationNameController.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    return super.close();
  }
}
