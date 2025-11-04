import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/core/utils/constants.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/auth/data/dataSource/login_data_source.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit of(BuildContext context) => BlocProvider.of<LoginCubit>(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login({required BuildContext context}) async {
    emit(LoginLoading());
    await LoginDataSource.login(
      data: {'email': emailController.text, 'password': passwordController.text, 'device_name': Constants.deviceId, 'fcm_token': Constants.fcmToken},
    ).then((value) {
      value.fold(
        (l) {
          emit(LoginError(e: l.errMessage));
          log('register errors==> ${l.errMessage}');
          customShowToast(context, l.errMessage, showToastStatus: ShowToastStatus.error);
        },
        (r) async {
          ConstantsModels.loginModel = r;
          Constants.token = r.data?.userInfo?.accessToken ?? '';
          await userCache?.put(userCacheKey, jsonEncode(r.toJson()));
          userCacheValue = r.data?.userInfo;
          context.navigateToPageWithReplacement(const NavigationView());
          emit(LoginSuccess());
        },
      );
    });
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    emailController.dispose();
    return super.close();
  }
}
