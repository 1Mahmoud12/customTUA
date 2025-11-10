import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_images.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/auth/views/presentation/login_view.dart';

import '../../../../../core/utils/bottomSheet/delete_account_dialog.dart';

Future<void> loginRequiredDialog(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return StatefulBuilder(
        builder:
            (context, setState) => SpringAnimationDialog(
              dialog: AlertDialog(
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppImages.warning, fit: BoxFit.contain, width: 90, height: 90),
                    const SizedBox(height: 16),
                  ],
                ),
                content: Text(
                  'you_need_to_login_to_access_this_feature'.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextButton(
                          backgroundColor: AppColors.white,
                          colorText: AppColors.cP50,
                          borderColor: AppColors.cP50,
                          onPress: () {
                            Navigator.pop(context);
                          },
                          childText: 'cancel'.tr(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomTextButton(
                          backgroundColor: AppColors.cP50,
                          colorText: AppColors.white,
                          borderColor: AppColors.cP50,
                          onPress: () {
                            Navigator.pop(context);
                            context.navigateToPage(const LoginView());
                          },
                          childText: 'login_now'.tr(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      );
    },
  );
}
