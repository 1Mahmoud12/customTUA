import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/auth/views/presentation/login_view.dart';

import '../manager/forgotPasswordCubit/cubit/forgot_password_cubit.dart';
import 'otp_view.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final _formKey = GlobalKey<FormState>();
  final cubit = ForgotPasswordCubit();

  final RegExp _emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'email_required'.tr();
    if (!_emailRegExp.hasMatch(value)) return 'email_invalid'.tr();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'forgot_password'),
      body: BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                builder: (context, state) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        SvgPicture.asset(AppIcons.forgetPasswordIc),
                        Text('forgot_password'.tr(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
                        Text(
                          'don’t_worry_it_occurs,_please_enter_the_email_address_linked_with_your_account.'.tr(),
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.cP50),
                        ),
                        const SizedBox(height: 0),
                        CustomTextFormField(
                          enable: state is! ForgotPasswordLoading,
                          controller: cubit.emailController,
                          hintText: 'email_hint'.tr(),
                          nameField: 'email'.tr(),
                          textInputType: TextInputType.emailAddress,
                          validator: _validateEmail,
                        ),

                        CustomTextButton(
                          state: state is ForgotPasswordLoading,
                          childText: 'continue'.tr(),

                          onPress: () {
                            // if (_formKey.currentState!.validate()) {
                            context.navigateToPageWithReplacement(OTPVerificationView());
                            // }
                          },
                        ),
                      ].paddingDirectional(top: 24),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        InkWell(
          onTap: () {
            context.navigateToPage(LoginView());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text.rich(
                TextSpan(
                  text: 'Remmember Password? '.tr(),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.cP50),
                  children: [TextSpan(text: 'Login'.tr(), style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.primaryColor))],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
