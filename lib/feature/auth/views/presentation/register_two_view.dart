import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/auth/views/manager/registerCubit/cubit/register_cubit.dart';
import 'package:tua/feature/auth/views/presentation/login_view.dart';
import 'package:tua/feature/auth/views/presentation/widgets/link_text.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/phone_field_widget.dart';

class RegisterTwoView extends StatefulWidget {
  final RegisterCubit registerCubit;

  const RegisterTwoView({super.key, required this.registerCubit});

  @override
  State<RegisterTwoView> createState() => _RegisterTwoViewState();
}

class _RegisterTwoViewState extends State<RegisterTwoView> {
  final _formKey = GlobalKey<FormState>();
  late RegisterCubit registerCubit;

  @override
  void initState() {
    registerCubit = widget.registerCubit;
    super.initState();
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
                  return Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
                        ),
                      ),
                      Center(child: SvgPicture.asset(AppIcons.logoAppIc)),
                      Text('complete_your_account_info'.tr(), style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
                      CustomTextFormField(
                        enable: state is! RegisterLoading,
                        controller: registerCubit.firstNameController,
                        hintText: ' '.tr(),
                        nameField: 'first_name'.tr(),
                        textInputType: TextInputType.name,
                      ),
                      CustomTextFormField(
                        enable: state is! RegisterLoading,
                        controller: registerCubit.lastNameController,
                        hintText: ' '.tr(),
                        nameField: 'last_name'.tr(),
                        textInputType: TextInputType.name,
                      ),

                      CustomDropDownMenu(
                        selectedItem: DropDownModel(name: 'select_gender', value: -1),
                        items: ConstantsModels.lookupModel?.data?.genders
                                ?.map((e) => DropDownModel(name: e.name.tr(), value: e.name))
                                .toList() ??
                            [],
                        onChanged: (val) {
                          if (val != null) {
                            registerCubit.setGender(val.value);
                            debugPrint("gender sent: ${val.value}");

                          }
                        },
                      ),
                      CustomDropDownMenu(
                        selectedItem: DropDownModel(name: 'select_nationality', value: -1),
                        items: ConstantsModels.lookupModel?.data?.nationalities
                                ?.map((e) => DropDownModel(name: e.name ?? '', value: e.id))
                                .toList() ??
                            [],
                        onChanged: (val) {
                          if (val != null) {
                            registerCubit.setNationality(val.value);

                          }
                        },
                      ),
                      CustomDropDownMenu(
                        selectedItem: DropDownModel(name: 'select_residence'.tr(), value: -1),
                        items: ConstantsModels.lookupModel?.data?.residencies
                                ?.map((e) => DropDownModel(name: e.name ?? '', value: e.id))
                                .toList() ??
                            [],
                        onChanged: (val) {
                          if (val != null) {
                            registerCubit.setResidency(val.value);
                          }
                        },
                      ),
                      PhoneFieldWidget(
                        // hintText: 'enter_your_phone'.tr(),
                        nameField: 'phone_number'.tr(),

                        onChange: (p0) {
                          registerCubit.phoneController.text = p0;
                        },
                      ),
                      CustomTextButton(
                        state: state is RegisterLoading,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            registerCubit.register(context: context);
                          }
                        },
                        childText: 'create_account'.tr(),
                      ),
                      Center(
                        child: LinkText(
                          mainText: 'already_have_an_account'.tr(),
                          linkText: 'login'.tr(),
                          onLinkTap: () {
                            context.navigateToPage(const LoginView());
                          },
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
