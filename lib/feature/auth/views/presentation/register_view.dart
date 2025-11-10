import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_check_box.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/app_images.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/auth/views/manager/registerCubit/cubit/register_cubit.dart';
import 'package:tua/feature/auth/views/presentation/login_view.dart';
import 'package:tua/feature/auth/views/presentation/register_two_view.dart';
import 'package:tua/feature/auth/views/presentation/widgets/link_text.dart';
import 'package:tua/feature/staticPages/view/presentation/privacy_policy_view.dart';
import '../../../../core/component/loadsErros/loading_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterCubit registerCubit = RegisterCubit();
  final _formKey = GlobalKey<FormState>();

  final RegExp _emailRegExp =
  RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'email_required'.tr();
    if (!_emailRegExp.hasMatch(value)) return 'email_invalid'.tr();
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'password_required'.tr();
    if (value.length < 6) return 'password_length'.tr();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: BlocProvider.value(
              value: registerCubit,
              child: BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                            child: SvgPicture.asset(AppIcons.logoAppIc,
                                width: 80, height: 80)),
                        const SizedBox(height: 16),
                        Text('create_new_account'.tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 24),
                        CustomTextFormField(
                          enable: state is! RegisterLoading,
                          controller: registerCubit.emailController,
                          hintText: 'email_hint'.tr(),
                          nameField: 'email'.tr(),
                          textInputType: TextInputType.emailAddress,
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          enable: state is! RegisterLoading,
                          controller: registerCubit.passwordController,
                          hintText: 'password'.tr(),
                          nameField: 'password_field'.tr(),
                          password: true,
                          validator: _validatePassword,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          enable: state is! RegisterLoading,
                          controller: registerCubit.confirmPasswordController,
                          hintText: 'enter_confirm_password'.tr(),
                          nameField: 'confirm_password'.tr(),
                          password: true,
                          validator: _validatePassword,
                        ),
                        const SizedBox(height: 16),
                        CustomCheckBox(
                          onTap: (value) {
                            registerCubit.changeTermsConditions();
                          },
                          checkBox: registerCubit.isTermsConditions,
                          borderColor:
                          AppColors.cP50.withAlpha((.5 * 255).toInt()),
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text.rich(
                                TextSpan(
                                  text: 'By creating an account, you agree to our '.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                      text: 'Privacy Policy'.tr(),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => context.navigateToPage(
                                            const PrivacyPolicyView()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (state is RegisterLoading)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: LoadingWidget(),
                          )
                        else
                          CustomTextButton(
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                if (registerCubit.passwordController.text ==
                                    registerCubit.confirmPasswordController.text) {
                                  context.navigateToPage(
                                      RegisterTwoView(registerCubit: registerCubit));
                                } else {
                                  customShowToast(
                                      context, 'password_not_match'.tr());
                                }
                              }
                            },
                            childText: 'complete_your_account'.tr(),
                          ),
                        const SizedBox(height: 16),
                        Center(
                          child: LinkText(
                            mainText: 'already_have_an_account'.tr(),
                            linkText: 'sign_in_now'.tr(),
                            onLinkTap: () {
                              context.navigateToPage(const LoginView());
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Expanded(
                                child:
                                Divider(color: AppColors.cBorderButtonColor)),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('or'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(color: AppColors.cBorderButtonColor)),
                            ),
                            const Expanded(
                                child:
                                Divider(color: AppColors.cBorderButtonColor)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextButton(
                          onPress: () {},
                          backgroundColor: AppColors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.google, width: 24, height: 24),
                              const SizedBox(width: 8),
                              Text(
                                'continue_with_google'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                    color: AppColors.greyG600,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextButton(
                          onPress: () {},
                          backgroundColor: AppColors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.apple, width: 24, height: 24),
                              const SizedBox(width: 8),
                              Text(
                                'continue_with_apple'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                    color: AppColors.greyG600,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextButton(
                          onPress: () {},
                          backgroundColor: AppColors.white,
                          child: Text(
                            'continue_as_guest'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
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
