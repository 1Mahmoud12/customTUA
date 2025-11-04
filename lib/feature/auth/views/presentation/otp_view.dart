import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';

import '../manager/otpCubit/cubit/otp_cubit.dart';
import 'reset_password_view.dart';

class OTPVerificationView extends StatelessWidget {
  OTPVerificationView({super.key});

  final cubit = OTPCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'OTP'.tr()),
      body: BlocProvider.value(
        value: cubit,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<OTPCubit, OTPState>(
              builder: (context, state) {
                final cubit = context.read<OTPCubit>();
                return Column(
                  children: [
                    SvgPicture.asset(AppIcons.forgetPasswordIc),
                    Text('check_your_email'.tr(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
                    Text(
                      'we’ve_send_the_code_to_your_email_address'.tr(),
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.cP50),
                      textAlign: TextAlign.center,
                    ),

                    PinCodeTextField(
                      length: 4,
                      appContext: context,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10.r),
                        fieldHeight: 50.h,
                        fieldWidth: 50.w,
                        activeFillColor: AppColors.white,
                        inactiveColor: Colors.grey.shade300,
                        inactiveFillColor: Colors.white,
                        activeColor: AppColors.primaryColor,
                        selectedFillColor: AppColors.cP50.withAlpha((0.05 * 255).toInt()),
                        selectedColor: AppColors.primaryColor,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: cubit.codeController,
                      hintCharacter: '-',

                      onCompleted: (v) {},
                      onChanged: (value) {
                        debugPrint(value);
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: cubit.resendCode,
                          child: Text.rich(
                            TextSpan(
                              text: ' ${'resend_code'.tr()} ',
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.cP50),
                              children: [
                                if (state is OTPTimerRunning)
                                  TextSpan(
                                    text: state.timerText,
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.primaryColor),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomTextButton(
                      state: state is OTPLoading,
                      childText: 'send'.tr(),
                      onPress: () {
                        context.navigateToPageWithReplacement(ResetPasswordView());
                      },
                    ),
                  ].paddingDirectional(top: 24),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
