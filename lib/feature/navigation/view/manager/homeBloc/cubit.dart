import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/core/utils/constants.dart';
import 'package:tua/feature/navigation/view/manager/homeBloc/state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit of(BuildContext context) => BlocProvider.of<MainCubit>(context);

  void changeLanguage(Locale locale, BuildContext context) {
    context.setLocale(locale);
    arabicLanguage = locale.languageCode == 'ar';
    log('cubit $arabicLanguage');
    Constants.fontFamily = arabicLanguage ? 'Alexandria' : 'Alexandria';
    userCache?.put(languageAppKey, arabicLanguage);
    emit(ChangeInitialState());
  }

  void changeTheme(BuildContext context) {
    darkModeValue = !darkModeValue;

    userCache?.put(darkModeKey, darkModeValue);

    emit(ChangeThemeState());
  }

  void changeState() {
    emit(HomeChangeState());
  }

  // final NotificationDataSource notificationDataSource = NotificationDataSourceImpl();
  // int notificationCount = 0;
  //
  // void getNotificationCount() async {
  //   emit(GetHomeNotificationLoadingState());
  //   // animationDialogLoading(context);
  //   notificationDataSource.notificationCount().then(
  //     (value) async {
  //       //  closeDialog(context);
  //       // bool result = await InternetConnectionChecker().hasConnection;
  //       value.fold((l) {
  //         Utils.showToast(title: l.errMessage, state: UtilState.error);
  //         emit(GetHomeNotificationErrorState(l.errMessage));
  //       }, (r) {
  //         notificationCount = r.toInt();
  //
  //         emit(GetHomeNotificationSuccessState());
  //       });
  //     },
  //   );
  // }
  //
  // void clearAllNotification() {
  //   notificationCount = 0;
  //   emit(ReadHomeAllNotificationState());
  // }
  //
  // void readOneNotification() {
  //   notificationCount--;
  //   emit(ReadHomeOneNotificationState());
  // }
}
