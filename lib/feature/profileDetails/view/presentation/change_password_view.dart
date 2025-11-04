import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/profileDetails/view/presentation/success_change_password_view.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'change_password'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(),
          CustomTextFormField(
            controller: TextEditingController(),
            nameField: 'current_password',
            hintText: 'enter_current_password',
            textInputType: TextInputType.visiblePassword,
          ),
          CustomTextFormField(
            controller: TextEditingController(),
            nameField: 'new_password',
            hintText: 'enter_new_password',
            textInputType: TextInputType.visiblePassword,
          ),
          CustomTextFormField(
            controller: TextEditingController(),
            nameField: 'confirm_new_password',
            hintText: 'enter_confirm_new_password',
            textInputType: TextInputType.visiblePassword,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(AppIcons.smallInfoIc),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Please make sure you remember and login with your new password you just created. Changes are reflected real-time after you changed your password.'
                      .tr(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50.withAlpha((0.5 * 255).toInt())),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomTextButton(
            onPress: () {
              context.navigateToPage(const SuccessChangePasswordView());
            },
            childText: 'change_password',
          ),
        ].paddingDirectional(top: 20),
      ),
    );
  }
}
