// change_password_view.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/profileDetails/view/presentation/success_change_password_view.dart';

import '../../data/data_source/profile_details_data_source_impl.dart';
import '../manager/change_password_cubit/change_password_cubit.dart';
import '../manager/change_password_cubit/change_password_state.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePasswordCubit(ProfileDetailsDataSourceImpl()),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            context.navigateToPage(const SuccessChangePasswordView());
          } else if (state is ChangePasswordFailure) {
            customShowToast(context, state.message.tr(), showToastStatus: ShowToastStatus.error);
          }
        },
        builder: (context, state) {
          final cubit = context.read<ChangePasswordCubit>();

          return Scaffold(
            appBar: customAppBar(context: context, title: 'change_password'),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                CustomTextFormField(
                  controller: cubit.passwordController,
                  nameField: 'password',
                  hintText: 'password_hint',
                  textInputType: TextInputType.visiblePassword,
                ),
                CustomTextFormField(
                  controller: cubit.newPasswordController,
                  nameField: 'new_password',
                  hintText: 'enter_new_password',
                  textInputType: TextInputType.visiblePassword,
                ),
                CustomTextFormField(
                  controller: cubit.confirmNewPasswordController,
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
                if (state is ChangePasswordLoading)
                  const LoadingWidget()
                else
                  CustomTextButton(onPress: () => cubit.changePassword(), childText: 'change_password'),
              ].paddingDirectional(top: 20),
            ),
          );
        },
      ),
    );
  }
}
