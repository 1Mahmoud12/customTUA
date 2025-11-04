import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/auth/views/presentation/successfullty_view.dart';

import '../manager/resetPasswordCubit/cubit/reset_password_cubit.dart';
import 'login_view.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ResetPasswordCubit cubit = ResetPasswordCubit();

    return Scaffold(
      appBar: customAppBar(context: context, title: 'reset_password'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: BlocProvider.value(
              value: cubit,
              child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      SvgPicture.asset(AppIcons.forgetPasswordIc),
                      Text('check_your_email'.tr(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
                      Text(
                        'replace_the_password_with_a_new_and_strong_characters.'.tr(),
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.cP50),
                        textAlign: TextAlign.center,
                      ),
                      CustomTextFormField(
                        enable: state is! ResetPasswordLoading,
                        controller: cubit.newPasswordController,
                        hintText: 'password_hint'.tr(),
                        nameField: 'new_password'.tr(),
                        password: true,
                        validator: cubit.validatePassword,
                      ),
                      CustomTextFormField(
                        enable: state is! ResetPasswordLoading,
                        controller: cubit.confirmPasswordController,
                        hintText: 'password_hint'.tr(),
                        nameField: 'confirm_password'.tr(),
                        password: true,
                        validator: cubit.validateConfirmPassword,
                      ),
                      const SizedBox(height: 0),
                      CustomTextButton(
                        state: state is ResetPasswordLoading,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.resetPassword(context: context).then((value) {
                              if (context.mounted) {
                                context.navigateToPage(const SuccessfullyView());
                              }
                            });
                          }
                        },
                        childText: 'change_password'.tr(),
                      ),
                      const SizedBox(height: 0),
                      InkWell(
                        onTap: () {
                          context.navigateToPage(const LoginView());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                text: 'Remmember Password? '.tr(),
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.cP50),
                                children: [
                                  TextSpan(
                                    text: 'Login'.tr(),
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ].paddingDirectional(top: 24),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
