import 'dart:convert';
import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:tua/core/network/dio_helper.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/core/network/local/hive_data_base.dart';
import 'package:tua/core/utils/bloc_observe.dart';
import 'package:tua/core/utils/constants.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/core/utils/notification/notification.dart';
import 'package:tua/feature/auth/data/models/login_model.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';
import 'package:tua/feature/splash/view/presentation/splash_screen_view.dart';

import 'firebase_options.dart';
import 'my_app.dart';

//PusherService pusherService = PusherService();
// Widget appStartScreen = ForgotPasswordView();
Widget appStartScreen = const SplashScreenView();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Logger logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  EasyLocalization.logger.enableBuildModes = [];
  // Hive
  await Hive.initFlutter();

  // Dio
  await DioHelper.init();

  userCache = await openHiveBox(userCacheBoxKey);
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: AppColors.scaffoldBackGround, // Make status bar transparent
  //     statusBarIconBrightness: Brightness.dark, // Dark icons for light background
  //     statusBarBrightness: Brightness.light, // iOS: light status bar for dark icons
  //   ),
  // );
  onBoardingValue = userCache?.get(onBoardingKey, defaultValue: true);
  darkModeValue = userCache?.get(darkModeKey, defaultValue: false);
  locationCacheValue = userCache?.get(locationCacheKey);
  final String? cacheData = await userCache?.get(userCacheKey, defaultValue: '{}');
  ConstantsModels.loginModel = cacheData != null ? LoginModel.fromJson(jsonDecode(cacheData)) : null;
  userCacheValue = ConstantsModels.loginModel?.data?.userInfo;
  Constants.token = ConstantsModels.loginModel?.data?.userInfo?.accessToken ?? '';
  Constants.fcmToken = await userCache?.get(fcmTokenKey, defaultValue: '');
  Constants.deviceId = await userCache?.get(deviceIdKey, defaultValue: '');
  arabicLanguage = await userCache?.get(languageAppKey, defaultValue: false);

  //Constants.fontFamily = arabicLanguage ? 'Tajawal' : 'Inter';
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationUtility.initializeAwesomeNotification();
  try {
    Constants.messageGlobal = await FirebaseMessaging.instance.getInitialMessage();
    if (Constants.messageGlobal?.data != null) {
      appStartScreen = const NavigationView();
    }
    log('appStartScreen $appStartScreen');
  } catch (error) {
    log('$error');
  }
  // rootBundle.loadString('assets/services/map.json').then((string) {
  //   Constants.mapStyleString = string;
  // });
  //selectTokens();
  //Constants.jsonServerKey = await loadJsonFile();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],
      path: 'assets/translation',
      startLocale: const Locale('en', 'US'),
      child: DevicePreview(enabled: false, builder: (context) => const MyApp()),
    ),
  );
}
