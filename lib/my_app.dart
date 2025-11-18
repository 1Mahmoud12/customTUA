import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/core/themes/light.dart';
import 'package:tua/core/utils/constants.dart';
import 'package:tua/feature/cart/data/data_source/cart_data_source_impl.dart';
import 'package:tua/feature/cart/view/managers/add_cart_item/add_cart_item_cubit.dart';
import 'package:tua/feature/donations/data/data_source/donation_programs_data_source.dart';
import 'package:tua/feature/donations/view/manager/donation_programs_cubit.dart';
import 'package:tua/feature/navigation/view/manager/homeBloc/cubit.dart';
import 'package:tua/feature/navigation/view/manager/homeBloc/state.dart';
import 'package:tua/main.dart';
import 'package:tua/social_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      arabicLanguage = context.locale.languageCode == 'ar';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, child) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => MainCubit()..getCurrency()),
              BlocProvider(create: (context) => AddCartItemCubit(CartDataSourceImpl())),
              BlocProvider(create: (_) => DonationProgramsCubit(DonationProgramsDataSource())..fetchDonationPrograms()),
              // BlocProvider(
              //   lazy: false,
              //   create: (context) => AuthCubit()..getCountryCode(),
              // ),
              // BlocProvider(
              //   create: (context) => BookCubit(),
              // ),
              // BlocProvider(
              //   create: (context) => OrderCubit(),
              // ),
              // BlocProvider(
              //   create: (context) => ManageAddressesCubit(),
              // ),
              // BlocProvider(
              //   create: (context) => ProceedCubit(),
              // ),
              // BlocProvider(
              //   create: (context) => CartCubit(),
              // ),
            ],
            child: BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                return Platform.isAndroid ? SafeArea(top: false, child: buildMaterialApp(context)) : buildMaterialApp(context);
              },
            ),
          ),
    );
  }

  MaterialApp buildMaterialApp(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      //locale: DevicePreview.locale(context),
      //builder: DevicePreview.appBuilder,
      navigatorKey: navigatorKey,
      theme: Themes(Constants.fontFamily).light(),
      darkTheme: Themes(Constants.fontFamily).dark(),
      themeMode: darkModeValue ? ThemeMode.dark : ThemeMode.light,
      builder: (context, child) => child!,
      home: const SocialApp(),
    );
  }
}
