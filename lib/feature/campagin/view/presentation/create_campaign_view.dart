import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/campagin/view/manager/donation_types_cubit.dart';
import 'package:tua/feature/campagin/view/presentation/widgets/select_card_widget.dart';
import 'package:tua/feature/donations/data/data_source/donation_types_data_source.dart';

import '../../../../core/component/buttons/custom_text_button.dart';
import '../../../../core/component/custom_app_bar.dart';
import '../../../../core/component/fields/custom_text_form_field.dart';
import '../../../sponsorship/view/presentation/widgets/date_picker_dialog.dart';
import '../../../sponsorship/view/presentation/widgets/phone_field_widget.dart';
import '../../../volunteeringPrograms/data/data_source/volunteering_programs_data_source.dart';
import '../manager/create_campaign_cubit.dart';
import '../manager/create_campaign_state.dart';
import 'widgets/donation_type_dropdown.dart';

class CreateCampaignView extends StatelessWidget {
  const CreateCampaignView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateCampaignCubit(VolunteeringProgramsDataSource()),
      child: BlocConsumer<CreateCampaignCubit, CreateCampaignState>(
        builder: (context, state) {
          final cubit = context.read<CreateCampaignCubit>();
          return Scaffold(
            appBar: customAppBar(context: context, title: 'create_your_campaign'),
            body: Form(
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
                          controller: cubit.nameController,
                          hintText: 'enter_your_name',
                          textInputType: TextInputType.name,
                          nameField: 'your_name',
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'please_enter_your_name'.tr();
                            }
                            return null;
                          },
                        ),

                        /// ---------------------- MOBILE ----------------------
                        PhoneFieldWidget(nameField: 'mobile_number', onChange: (value) => cubit.mobileNumber = value),

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

                        /// ---------------------- CAMPAIGN NAME ----------------------
                        CustomTextFormField(
                          controller: cubit.campaignNameController,
                          hintText: 'enter_your_campaign_name',
                          nameField: 'campaign_name',
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'please_enter_campaign_name'.tr();
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          controller: cubit.messageController,
                          hintText: '~',
                          nameField: 'message',
                          maxLines: 4,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'please_enter_message'.tr();
                            }
                          },
                        ),
                        BlocProvider(
                          create: (context) => DonationTypesCubit(DonationTypesDataSource())..getDonationTypes(),
                          child: DonationTypeDropdown(onChanged: (value) => cubit.donationTypeId = value.toString()),
                        ),

                        /// ---------------------- START DATE ----------------------
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (_) => Center(
                                          child: BeautifulDatePicker(
                                            firstDate: DateTime.now(),
                                            initialDate: DateTime.now(),
                                            onDateSelected: cubit.onStartDateSelected,
                                          ),
                                        ),
                                  );
                                },
                                child: CustomTextFormField(
                                  enable: false,
                                  controller: cubit.startDateController,
                                  hintText: 'DD/MM/YYYY',
                                  nameField: 'start_date',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please_select_start_date'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(width: 16),

                            /// ---------------------- END DATE ----------------------
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (_) => Center(
                                          child: BeautifulDatePicker(
                                            firstDate: DateTime.now(),
                                            initialDate: DateTime.now(),
                                            onDateSelected: cubit.onEndDateSelected,
                                          ),
                                        ),
                                  );
                                },
                                child: CustomTextFormField(
                                  enable: false,
                                  controller: cubit.endDateController,
                                  hintText: 'DD/MM/YYYY',
                                  nameField: 'end_date',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please_select_end_date'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ].paddingDirectional(top: 16),
                    ),
                  ),

                  SelectCardWidget(
                    onCardSelected: (value) {
                      log(value.toString());
                    },
                  ),

                  /// ---------------------- SUBMIT BUTTON ----------------------
                  if (state is CreateCampaignLoading)
                    const LoadingWidget()
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CustomTextButton(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        onPress: () => cubit.submitForm(context),
                        childText: 'submit',
                      ),
                    ),
                  SizedBox(height: 24),
                ].paddingDirectional(top: 16),
              ),
            ),
          );
        },
        listener: (context, state) {
          // if (state is CreateCampaignSuccess) {
          //   customShowToast(context, 'campaign_created_successfully'.tr());
          // }

          if (state is CreateCampaignFailure) {
            customShowToast(context, state.message.tr(), showToastStatus: ShowToastStatus.error);
          }
        },
      ),
    );
  }
}
