import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_images.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/auth/views/presentation/login_view.dart';
import 'package:tua/feature/common/data/dataSource/lookup_data_source.dart';
import 'package:tua/feature/common/data/models/lookup_model.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    _prefetchLookup();
    Timer(const Duration(seconds: 2), () {
      if (userCacheValue == null) {
        context.navigateToPage(const LoginView());
      } else {
        if (mounted) context.navigateToPage(const NavigationView());
      }
    });
  }

  void _prefetchLookup() async {
    // if cached, load into memory
    final String? cached = userCache?.get(lookupCacheKey);
    if (cached != null && cached.isNotEmpty) {
      try {
        ConstantsModels.lookupModel = null; // reset
        ConstantsModels.lookupModel =
        // ignore: avoid_dynamic_calls
        LookupModel.fromJson(jsonDecode(cached) as Map<String, dynamic>);
      } catch (_) {}
    }

    final result = await LookupDataSource.fetchLookup();
    result.fold((_) {}, (model) async {
      ConstantsModels.lookupModel = model;
      await userCache?.put(lookupCacheKey, jsonEncode(model.toJson()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackGround,
      body: Center(
        child: Image.asset(AppImages.logoApp, width: context.screenWidth * .5)
            .animate()
            .fade(duration: const Duration(milliseconds: 700))
            .slide(duration: const Duration(milliseconds: 800), begin: const Offset(0, 1), end: Offset.zero, curve: Curves.fastOutSlowIn)
            .scale(
              //  delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 800),
              begin: const Offset(.9, .9),
              end: const Offset(1, 1),
            ),
      ),
    );
  }
}
