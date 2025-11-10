import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/app_images.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/auth/views/manager/loginCubit/cubit/login_cubit.dart';
import 'package:tua/feature/auth/views/presentation/forget_password_view.dart';
import 'package:tua/feature/auth/views/presentation/register_view.dart';
import 'package:tua/feature/auth/views/presentation/widgets/link_text.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginCubit loginCubit = LoginCubit();
  final _formKey = GlobalKey<FormState>();

  // Email validation regex pattern
  final RegExp _emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  // Email validator
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'email_required'.tr();
    }
    if (!_emailRegExp.hasMatch(value)) {
      return 'email_invalid'.tr();
    }
    return null;
  }

  // Password validator
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password_required'.tr();
    }
    // if (value.length < 6) {
    //   return 'password_length'.tr();
    // }
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
              value: loginCubit,
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Center(child: SvgPicture.asset(AppIcons.logoAppIc)),
                      Text(
                        'sign_in_to_your_account'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      CustomTextFormField(
                        enable: state is! LoginLoading,
                        controller: loginCubit.emailController,
                        hintText: 'email_hint'.tr(),
                        nameField: 'email'.tr(),
                        textInputType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      Column(
                        children: [
                          CustomTextFormField(
                            enable: state is! LoginLoading,
                            controller: loginCubit.passwordController,
                            hintText: 'password'.tr(),
                            nameField: 'password_field'.tr(),
                            password: true,
                            validator: _validatePassword,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => context.navigateToPage(ForgotPasswordView()),
                                child: Text(
                                  'forgot_password'.tr(),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displayMedium?.copyWith(color: AppColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (state is LoginLoading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: LoadingWidget(),
                        )
                      else
                        CustomTextButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              loginCubit.login(context: context);
                            }
                          },
                          childText: 'login'.tr(),
                          showArrowButton: true,
                        ),
                      Center(
                        child: LinkText(
                          mainText: 'dont_have_account'.tr(),
                          linkText: 'create_new_account'.tr(),
                          onLinkTap: () {
                            context.navigateToPage(const RegisterView());
                          },
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(child: Divider(color: AppColors.cBorderButtonColor)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'or'.tr(),
                              style: Theme.of(
                                context,
                              ).textTheme.displayMedium?.copyWith(color: AppColors.cBorderButtonColor),
                            ),
                          ),
                          const Expanded(child: Divider(color: AppColors.cBorderButtonColor)),
                        ],
                      ),
                      CustomTextButton(
                        onPress: () {},
                        backgroundColor: AppColors.white,

                        child: Row(
                          children: [
                            Image.asset(AppImages.google, width: 24, height: 24),
                            const SizedBox(width: 8),
                            Text(
                              'continue_with_google'.tr(),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.greyG600,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      CustomTextButton(
                        onPress: () {},
                        backgroundColor: AppColors.white,
                        child: Row(
                          children: [
                            Image.asset(AppImages.apple, width: 24, height: 24),
                            const SizedBox(width: 8),
                            Text(
                              'continue_with_apple'.tr(),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.greyG600,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      CustomTextButton(
                        onPress: () {
                          context.navigateToPage(const NavigationView());
                        },
                        backgroundColor: AppColors.white,

                        child: Text(
                          'continue_as_guest'.tr(),
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
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
