import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/checkout_as_a_visitor/data/data_source/checkout_as_visitor_data_source_impl.dart';
import 'package:tua/feature/checkout_as_a_visitor/view/manager/checkout_as_visitor_cubit.dart';
import 'package:tua/feature/checkout_as_a_visitor/view/manager/verify_otp_cubit.dart';
import 'package:tua/feature/checkout_as_a_visitor/view/presentation/verify_otp_view.dart';

import '../../../../core/component/buttons/custom_text_button.dart';
import '../../../../core/component/custom_app_bar.dart';
import '../../../../core/component/fields/custom_text_form_field.dart';
import '../../../../core/utils/custom_show_toast.dart';
import '../../../auth/views/presentation/login_view.dart';
import '../../../auth/views/presentation/otp_view.dart';
import '../../../auth/views/presentation/widgets/link_text.dart';
import '../../../sponsorship/view/presentation/widgets/phone_field_widget.dart';

class CheckoutAsAVisitorView extends StatelessWidget {
  const CheckoutAsAVisitorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'checkout_as_visitor'),
      body: BlocProvider(
        create: (context) => CheckoutAsVisitorCubit(dataSource: CheckoutAsVisitorDataSourceImpl()),
        child: BlocConsumer<CheckoutAsVisitorCubit, CheckoutAsVisitorState>(
          listener: (context, state) {
            if (state is CheckoutAsVisitorSuccess) {
              context.navigateToPage(const VerifyOtpView());
            }
            if (state is CheckoutAsVisitorError) {
              customShowToast(context, state.message, showToastStatus: ShowToastStatus.error);
            }
          },
          builder: (context, state) {
            final cubit = context.read<CheckoutAsVisitorCubit>();
            return Form(
              key: cubit.formKey, // ⭐ important
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        /// ---------------------- NAME ----------------------
                        CustomTextFormField(
                          controller: cubit.firstNameController,
                          hintText: 'enter_first_name',
                          textInputType: TextInputType.name,
                          nameField: 'first_name',
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'please_enter_your_name'.tr();
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          controller: cubit.lastNameController,
                          hintText: 'enter_last_name',
                          textInputType: TextInputType.name,
                          nameField: 'last_name',
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'please_enter_your_name'.tr();
                            }
                            return null;
                          },
                        ),
                        /// ---------------------- MOBILE ----------------------
                        PhoneFieldWidget(
                          nameField: 'mobile_number',
                          onChange: (value) => cubit.phoneController.text = value,
                        ),

                        /// ---------------------- EMAIL ----------------------
                        CustomTextFormField(
                          controller: cubit.emailController,
                          hintText: 'enter_your_email',
                          textInputType: TextInputType.emailAddress,
                          nameField: 'your_email',
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'please_enter_email'.tr();
                            }
                            if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(val)) {
                              return 'please_enter_valid_email'.tr();
                            }
                            return null;
                          },
                        ),
                      ].paddingDirectional(top: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  /// ---------------------- SUBMIT BUTTON ----------------------
                  if (state is CheckoutAsVisitorLoading)
                    const LoadingWidget()
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CustomTextButton(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        onPress: () => cubit.checkoutAsVisitor(),
                        childText: 'continue',
                      ),
                    ),
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
                ].paddingDirectional(top: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
