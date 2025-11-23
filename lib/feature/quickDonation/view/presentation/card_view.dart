import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/custom_check_box.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/drop_menu.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/campagin/view/presentation/widgets/select_card_widget.dart';
import 'package:tua/feature/common/data/dataSource/e_card_data_source.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/date_picker_dialog.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/phone_field_widget.dart';

import '../../../cart/view/managers/get_user_info/get_user_info_cubit.dart';
import '../../../cart/view/managers/get_user_info/get_user_info_state.dart';

class CardView extends StatefulWidget {
  final String? amount;
  final String? donorId;

  const CardView({super.key, this.amount, this.donorId});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  final TextEditingController _senderNameController = TextEditingController();
  final TextEditingController _recipientNameController =
      TextEditingController();
  final TextEditingController _senderEmailController = TextEditingController();
  final TextEditingController _recipientEmailController =
      TextEditingController();
  String _senderPhone = '';
  String _recipientPhone = '';
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  int? _selectedCardId;
  DateTime? _selectedDate;
  bool _sendWhenFinished = false;
  bool _isLoading = false;
  String? _selectedDonorId;

  @override
  void initState() {
    super.initState();
    // Get donor_id from quick donation lookup or use provided one
    _selectedDonorId =
        widget.donorId ?? ConstantsModels.lookupModel?.data?.quickDonation?.id;
  }

  @override
  void dispose() {
    _senderNameController.dispose();
    _recipientNameController.dispose();
    _senderEmailController.dispose();
    _recipientEmailController.dispose();
    _messageController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _dateController.text = DateFormat('dd-MM-yyyy').format(date);
    });
  }

  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    // Remove any spaces or special characters
    final cleanedPhone = phone.replaceAll(RegExp(r'[^\d]'), '');

    // Must start with 962 (Jordan country code)
    if (!cleanedPhone.startsWith('962')) {
      return false;
    }

    // After 962, first digit must be 7 or 8
    if (cleanedPhone.length < 4) {
      return false;
    }

    final firstDigitAfterCountryCode = cleanedPhone[3];
    if (firstDigitAfterCountryCode != '7' &&
        firstDigitAfterCountryCode != '8') {
      return false;
    }

    // Total length should be 12 digits (962 + 9 digits)
    // Jordan phone format: 962 + 7/8 + 8 more digits = 12 total
    return cleanedPhone.length == 12;
  }

  Future<void> _sendECard() async {
    // Validation
    if (_senderNameController.text.trim().isEmpty) {
      customShowToast(
        context,
        'please_enter_sender_name'.tr(),
        showToastStatus: ShowToastStatus.error,
      );
      return;
    }
    if (_recipientNameController.text.trim().isEmpty) {
      customShowToast(
        context,
        'please_enter_recipient_name'.tr(),
        showToastStatus: ShowToastStatus.error,
      );
      return;
    }
    final senderEmail = _senderEmailController.text.trim();
    if (senderEmail.isEmpty) {
      customShowToast(
        context,
        'please_enter_sender_email'.tr(),
        showToastStatus: ShowToastStatus.error,
      );
      return;
    }
    if (!_isValidEmail(senderEmail)) {
      customShowToast(
        context,
        'please_enter_valid_email'.tr(),
        showToastStatus: ShowToastStatus.error,
      );
      return;
    }

    final recipientEmail = _recipientEmailController.text.trim();
    if (recipientEmail.isEmpty) {
      customShowToast(
        context,
        'please_enter_recipient_email'.tr(),
        showToastStatus: ShowToastStatus.error,
      );
      return;
    }
    if (!_isValidEmail(recipientEmail)) {
      customShowToast(
        context,
        'please_enter_valid_email'.tr(),
        showToastStatus: ShowToastStatus.error,
      );
      return;
    }

    if (_senderPhone.trim().isEmpty) {
      customShowToast(
        context,
        'please_enter_sender_phone'.tr(),
        showToastStatus: ShowToastStatus.error,
      );
      return;
    }
    if (!_isValidPhone(_senderPhone)) {
      customShowToast(
        context,
        'please_enter_valid_phone'.tr(),
        showToastStatus: ShowToastStatus.error,
      );
      return;
    }

    if (_recipientPhone.trim().isEmpty) {
      customShowToast(
        context,
        'please_enter_recipient_phone'.tr(),
        showToastStatus: ShowToastStatus.error,
      );
      return;
    }
    if (!_isValidPhone(_recipientPhone)) {
      customShowToast(
        context,
        'please_enter_valid_phone'.tr(),
        showToastStatus: ShowToastStatus.error,
      );
      return;
    }
    if (_selectedDonorId == null || _selectedDonorId!.isEmpty) {
      customShowToast(
        context,
        'donor_not_selected'.tr(),
        showToastStatus: ShowToastStatus.error,
      );
      return;
    }
    if (widget.amount == null || widget.amount!.isEmpty) {
      customShowToast(
        context,
        'please_select_an_amount'.tr(),
        showToastStatus: ShowToastStatus.error,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await ECardDataSource.sendECard(
      amount: widget.amount ?? '0',
      senderName: _senderNameController.text.trim(),
      recipientName: _recipientNameController.text.trim(),
      senderEmail: _senderEmailController.text.trim(),
      senderMobileNumber: _senderPhone.trim(),
      recipientEmail: _recipientEmailController.text.trim(),
      recipientMobileNumber: _recipientPhone.trim(),
      donorId: _selectedDonorId!,
      eCardId: _selectedCardId?.toString() ?? '',
      message: _messageController.text.trim(),
      sendWhenFinished: _sendWhenFinished ? '1' : '0',
      startDate:
          _selectedDate != null
              ? DateFormat('dd-MM-yyyy').format(_selectedDate!)
              : '',
    );

    setState(() {
      _isLoading = false;
    });

    result.fold(
      (failure) {
        customShowToast(
          context,
          failure.errMessage,
          showToastStatus: ShowToastStatus.error,
        );
      },
      (_) {
        customShowToast(context, 'e_card_sent_successfully'.tr());
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'send_as_a_e_card'),
      body:
          _isLoading
              ? const LoadingWidget()
              : ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'details'.tr(),
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${'please_fill_out_the_fields_below'.tr()}:',
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.cP50.withAlpha(
                                  (.5 * 255).toInt(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        BlocBuilder<UserInfoCubit, GetUserInfoState>(
                          builder: (context, state) {
                            final cubit = context.read<UserInfoCubit>();
                            return cubit.users.isNotEmpty
                                ? CustomPopupMenu(
                              nameField: 'select_donor',
                              selectedItem: DropDownModel(name: cubit.users.first.name, value: cubit.users.first.id),
                              items: cubit.users.map((e) => DropDownModel(name: e.name, value: e.id)).toList(),
                            )
                                : const SizedBox();
                          },
                        ),
                        CustomTextFormField(
                          controller: _senderNameController,
                          hintText: 'enter_sender_name',
                          textInputType: TextInputType.name,
                          nameField: 'sender_name',
                        ),
                        CustomTextFormField(
                          controller: _recipientNameController,
                          hintText: 'enter_recipient_name',
                          textInputType: TextInputType.name,
                          nameField: 'recipient_name',
                        ),
                        CustomTextFormField(
                          controller: _senderEmailController,
                          hintText: 'enter_sender_email',
                          textInputType: TextInputType.emailAddress,
                          nameField: 'sender_email',
                        ),
                        CustomTextFormField(
                          controller: _recipientEmailController,
                          hintText: 'enter_recipient_email',
                          textInputType: TextInputType.emailAddress,
                          nameField: 'recipient_email',
                        ),
                        PhoneFieldWidget(
                          nameField: 'sender_number',
                          onChange: (value) {
                            setState(() {
                              _senderPhone = value;
                            });
                          },
                        ),
                        PhoneFieldWidget(
                          nameField: 'recipient_number',
                          onChange: (value) {
                            setState(() {
                              _recipientPhone = value;
                            });
                          },
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => Center(
                                    child: BeautifulDatePicker(
                                      firstDate: DateTime.now(),
                                      onDateSelected: _onDateSelected,
                                      lastDate: DateTime.now().add(
                                        const Duration(days: 100),
                                      ),
                                    ),
                                  ),
                            );
                          },
                          child: CustomTextFormField(
                            enable: false,
                            controller: _dateController,
                            hintText: 'DD/MM/YYYY',
                            textInputType: TextInputType.datetime,
                            nameField: 'set_the_date',
                            prefixIcon: Padding(
                              padding: EdgeInsetsGeometry.only(
                                top: 16,
                                bottom: 16,
                                right:
                                    context.locale.languageCode == 'ar'
                                        ? 16
                                        : 0,
                                left:
                                    context.locale.languageCode == 'ar'
                                        ? 0
                                        : 16,
                              ),
                              child: SvgPicture.asset(AppIcons.dateIc),
                            ),
                          ),
                        ),
                      ].paddingDirectional(top: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SelectCardWidget(
                    onCardSelected: (cardId) {
                      setState(() {
                        _selectedCardId = cardId;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: _messageController,
                          hintText: 'message',
                          textInputType: TextInputType.text,
                          nameField: 'type_here',
                          maxLines: 3,
                          borderRadius: 10,
                        ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(vertical: 16),
                        //   decoration: BoxDecoration(
                        //     border: Border(
                        //       top: BorderSide(
                        //         color: AppColors.cP50.withAlpha(
                        //           (0.2 * 255).toInt(),
                        //         ),
                        //       ),
                        //       bottom: BorderSide(
                        //         color: AppColors.cP50.withAlpha(
                        //           (0.2 * 255).toInt(),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       SvgPicture.asset(AppIcons.previewIc),
                        //       const SizedBox(width: 8),
                        //       Text(
                        //         'preview_e_card'.tr(),
                        //         style: Theme.of(context).textTheme.displaySmall
                        //             ?.copyWith(color: AppColors.primaryColor),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        CustomCheckBox(
                          checkBox: true,
                          fillTrueValue: AppColors.cP50,
                          borderColor: AppColors.cP50,
                          onTap: (value) {
                            setState(() {
                              _sendWhenFinished = value;
                            });
                          },
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                'please_send_me_a_copy_of_the_e_card_when_it_is_sent'
                                    .tr(),
                                style: Theme.of(context).textTheme.displaySmall
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        CustomTextButton(
                          onPress: _sendECard,
                          childText: 'send_e_card'.tr(),
                        ),
                        const SizedBox(height: 16),
                      ].paddingDirectional(top: 16),
                    ),
                  ),
                ],
              ),
    );
  }
}
