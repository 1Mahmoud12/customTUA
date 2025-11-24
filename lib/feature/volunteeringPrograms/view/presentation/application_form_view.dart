import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/campagin/view/presentation/widgets/select_card_widget.dart';
import 'package:tua/feature/sponsorship/view/presentation/widgets/date_picker_dialog.dart' show BeautifulDatePicker;
import 'package:tua/feature/sponsorship/view/presentation/widgets/phone_field_widget.dart';
import 'package:tua/feature/volunteeringPrograms/data/data_source/volunteering_programs_data_source.dart';
import 'package:tua/feature/volunteeringPrograms/data/models/donation_campaign_request_model.dart';

class ApplicationFormView extends StatefulWidget {
  final int typeId;

  const ApplicationFormView({super.key, required this.typeId});

  @override
  State<ApplicationFormView> createState() => _ApplicationFormViewState();
}

class _ApplicationFormViewState extends State<ApplicationFormView> {
  final VolunteeringProgramsDataSource _dataSource = VolunteeringProgramsDataSource();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _campaignNameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _eCardIdController = TextEditingController();

  String _mobileNumber = '';
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _campaignNameController.dispose();
    _messageController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _eCardIdController.dispose();
    super.dispose();
  }

  void _onStartDateSelected(DateTime date) {
    setState(() {
      _startDate = date;
      _startDateController.text = DateFormat('dd-MM-yyyy').format(date);
    });
  }

  void _onEndDateSelected(DateTime date) {
    setState(() {
      _endDate = date;
      _endDateController.text = DateFormat('dd-MM-yyyy').format(date);
    });
  }

  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  Future<void> _submitForm() async {
    if (_nameController.text.trim().isEmpty) {
      customShowToast(context, 'please_enter_your_name'.tr(), showToastStatus: ShowToastStatus.error);
      return;
    }
    if (_mobileNumber.trim().isEmpty) {
      customShowToast(context, 'please_enter_mobile_number'.tr(), showToastStatus: ShowToastStatus.error);
      return;
    }
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      customShowToast(context, 'please_enter_email'.tr(), showToastStatus: ShowToastStatus.error);
      return;
    }
    if (!_isValidEmail(email)) {
      customShowToast(context, 'please_enter_valid_email'.tr(), showToastStatus: ShowToastStatus.error);
      return;
    }
    if (_campaignNameController.text.trim().isEmpty) {
      customShowToast(context, 'please_enter_campaign_name'.tr(), showToastStatus: ShowToastStatus.error);
      return;
    }
    if (_startDate == null) {
      customShowToast(context, 'please_select_start_date'.tr(), showToastStatus: ShowToastStatus.error);
      return;
    }
    if (_endDate == null) {
      customShowToast(context, 'please_select_end_date'.tr(), showToastStatus: ShowToastStatus.error);
      return;
    }

    if (_messageController.text.trim().isEmpty) {
      customShowToast(context, 'please_enter_message'.tr(), showToastStatus: ShowToastStatus.error);
      return;
    }
    if (_eCardIdController.text.trim().isEmpty) {
      customShowToast(context, 'please_enter_e_card_id'.tr(), showToastStatus: ShowToastStatus.error);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final request = DonationCampaignRequestModel(
      name: _nameController.text.trim(),
      mobileNumber: _mobileNumber.trim(),
      email: _emailController.text.trim(),
      campaignName: _campaignNameController.text.trim(),
      startDate: _startDateController.text.trim(),
      endDate: _endDateController.text.trim(),
      donationTypeId: widget.typeId.toString(),
      message: _messageController.text.trim(),
      eCardId: _eCardIdController.text.trim(),
    );

    final result = await _dataSource.createDonationCampaign(request);

    setState(() {
      _isLoading = false;
    });

    result.fold(
      (failure) {
        customShowToast(context, failure.errMessage, showToastStatus: ShowToastStatus.error);
      },
      (_) {
        // customShowToast(context, 'campaign_created_successfully'.tr());
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'application_form'),
      body:
          _isLoading
              ? const LoadingWidget()
              : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Text('To apply, please fill out the fields below!'.tr(), style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 16),

                  CustomTextFormField(
                    controller: _nameController,
                    hintText: 'enter_your_name',
                    textInputType: TextInputType.name,
                    nameField: 'your_name',
                  ),

                  PhoneFieldWidget(
                    nameField: 'mobile_number',
                    onChange: (value) {
                      setState(() {
                        _mobileNumber = value;
                      });
                    },
                  ),

                  CustomTextFormField(
                    controller: _emailController,
                    hintText: 'enter_your_email',
                    textInputType: TextInputType.emailAddress,
                    nameField: 'your_email',
                  ),

                  CustomTextFormField(
                    controller: _campaignNameController,
                    hintText: 'enter_campaign_name',
                    textInputType: TextInputType.text,
                    nameField: 'campaign_name',
                  ),

                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => Center(
                              child: BeautifulDatePicker(
                                firstDate: DateTime.now(),
                                onDateSelected: _onStartDateSelected,
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              ),
                            ),
                      );
                    },
                    child: CustomTextFormField(
                      enable: false,
                      controller: _startDateController,
                      hintText: 'DD-MM-YYYY',
                      textInputType: TextInputType.datetime,
                      nameField: 'start_date',
                      prefixIcon: Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 16,
                          bottom: 16,
                          right: context.locale.languageCode == 'ar' ? 16 : 0,
                          left: context.locale.languageCode == 'ar' ? 0 : 16,
                        ),
                        child: SvgPicture.asset(AppIcons.dateIc),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => Center(
                              child: BeautifulDatePicker(
                                firstDate: _startDate ?? DateTime.now(),
                                onDateSelected: _onEndDateSelected,
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              ),
                            ),
                      );
                    },
                    child: CustomTextFormField(
                      enable: false,
                      controller: _endDateController,
                      hintText: 'DD-MM-YYYY',
                      textInputType: TextInputType.datetime,
                      nameField: 'end_date',
                      prefixIcon: Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 16,
                          bottom: 16,
                          right: context.locale.languageCode == 'ar' ? 16 : 0,
                          left: context.locale.languageCode == 'ar' ? 0 : 16,
                        ),
                        child: SvgPicture.asset(AppIcons.dateIc),
                      ),
                    ),
                  ),

                  CustomTextFormField(
                    controller: _messageController,
                    hintText: 'enter_message',
                    textInputType: TextInputType.text,
                    nameField: 'message',
                    maxLines: 3,
                    borderRadius: 12,
                  ),

                  SelectCardWidget(
                    onCardSelected: (p0) {
                      setState(() {
                        _eCardIdController.text = p0.toString();
                      });
                    },
                  ),

                  const SizedBox(height: 24),
                  CustomTextButton(onPress: _submitForm, childText: 'submit'.tr()),
                  const SizedBox(height: 16),
                ].paddingDirectional(top: 16),
              ),
    );
  }
}
