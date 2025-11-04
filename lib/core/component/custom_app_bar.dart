import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tua/core/themes/colors.dart';

PreferredSizeWidget customAppBar({
  bool stopLeading = false,
  bool centerTitle = true,
  required BuildContext context,
  void Function()? onPressLeading,
  Widget? actions,
  String? title,
  double? titleSize,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    leading:
        stopLeading
            ? const SizedBox.shrink()
            : InkWell(
              onTap: onPressLeading ?? () => Navigator.pop(context),
              child: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
            ),
    centerTitle: centerTitle,
    title: Text(
      (title ?? '').tr(),
      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: titleSize ?? 18.sp),
    ),
    actions: [Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: actions ?? Container())],
    bottom: const PreferredSize(preferredSize: Size(double.infinity, 1), child: Divider(color: AppColors.cBorderButtonColor)),
    leadingWidth: 50,
    titleSpacing: 0,

    // toolbarHeight: 80,
  );
}
