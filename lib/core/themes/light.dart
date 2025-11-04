import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/themes/styles.dart';

class Themes {
  String family;

  Themes(this.family);

  ThemeData light() => ThemeData(
    splashColor: Colors.transparent,
    // Your desired splash color
    highlightColor: Colors.transparent,
    // Your desired highlight color
    scaffoldBackgroundColor: AppColors.scaffoldBackGround,
    cardColor: Colors.white,
    fontFamily: family,
    primaryColor: AppColors.primaryColor,
    dividerTheme: DividerThemeData(color: AppColors.transparent),
    appBarTheme: AppBarTheme(
      color: AppColors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
        // Dark icons for light background
        statusBarBrightness: Brightness.light,

        // iOS: light status bar for dark icons
        systemStatusBarContrastEnforced: true,
        systemNavigationBarColor: AppColors.scaffoldBackGround,
        systemNavigationBarDividerColor: AppColors.scaffoldBackGround,
      ),
    ),

    cardTheme: CardThemeData(shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15)), color: AppColors.white),
    textTheme: ThemeData.light().textTheme.copyWith(
      bodyLarge: Styles.style24700.copyWith(color: AppColors.black400, fontFamily: family),
      bodyMedium: Styles.style22700.copyWith(color: AppColors.black400, fontFamily: family),
      bodySmall: Styles.style20700.copyWith(color: AppColors.black400, fontFamily: family),
      titleLarge: Styles.style16700.copyWith(color: AppColors.black400, fontFamily: family),
      titleMedium: Styles.style15400.copyWith(color: AppColors.black400, fontFamily: family),
      titleSmall: Styles.style12400.copyWith(color: AppColors.black400, fontFamily: family),
      labelLarge: Styles.style15700.copyWith(color: AppColors.black400, fontFamily: family),
      labelMedium: Styles.style12400.copyWith(color: AppColors.black400, fontFamily: family),
      labelSmall: Styles.style10400.copyWith(color: AppColors.black400, fontFamily: family),
      displayLarge: Styles.style14400.copyWith(color: AppColors.lightTextColor, fontFamily: family),
      displayMedium: Styles.style14400.copyWith(color: AppColors.black400, fontFamily: family),
      displaySmall: Styles.style18500.copyWith(color: AppColors.black400, fontFamily: family),
    ),
    dialogTheme: const DialogThemeData(backgroundColor: AppColors.scaffoldBackGround),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.transparent),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor, // Custom cursor color
      selectionColor: AppColors.primaryColor.withAlpha((0.3 * 255).toInt()), // Custom selection color
      selectionHandleColor: AppColors.primaryColor, // Custom selection handle color
    ),
  );

  ThemeData dark() => ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    fontFamily: family,
    dividerTheme: DividerThemeData(color: AppColors.transparent),
    appBarTheme: AppBarTheme(
      color: AppColors.transparent,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    // cardTheme: CardTheme(shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15)), color: AppColors.white),
    textTheme: TextTheme(
      bodyLarge: Styles.style24700.copyWith(color: AppColors.white, fontFamily: family),
      bodyMedium: Styles.style22700.copyWith(color: AppColors.white, fontFamily: family),
      bodySmall: Styles.style20700.copyWith(color: AppColors.white, fontFamily: family),
      titleLarge: Styles.style16700.copyWith(color: AppColors.white, fontFamily: family),
      titleMedium: Styles.style15400.copyWith(color: AppColors.white, fontFamily: family),
      titleSmall: Styles.style12400.copyWith(color: AppColors.white, fontFamily: family),
      labelLarge: Styles.style15700.copyWith(color: AppColors.white, fontFamily: family),
      labelMedium: Styles.style12400.copyWith(color: AppColors.white, fontFamily: family),
      labelSmall: Styles.style10400.copyWith(color: AppColors.white, fontFamily: family),
      displayLarge: Styles.style14400.copyWith(color: AppColors.lightTextColor, fontFamily: family),
      displayMedium: Styles.style14400.copyWith(color: AppColors.white, fontFamily: family),
    ),
    // dialogTheme: DialogTheme(backgroundColor: AppColors.black),
  );
}
