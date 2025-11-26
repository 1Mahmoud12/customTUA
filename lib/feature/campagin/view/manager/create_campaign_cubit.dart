import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../volunteeringPrograms/data/data_source/volunteering_programs_data_source.dart';
import '../../../volunteeringPrograms/data/models/donation_campaign_request_model.dart';
import 'create_campaign_state.dart';

class CreateCampaignCubit extends Cubit<CreateCampaignState> {
  final VolunteeringProgramsDataSource _dataSource;

  /// Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final campaignNameController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final eCardIdController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final messageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String mobileNumber = '';
  DateTime? startDate;
  DateTime? endDate;
  String donationTypeId = '-1';

  CreateCampaignCubit(this._dataSource) : super(CreateCampaignInitial());

  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  void onStartDateSelected(DateTime date) {
    startDate = date;
    startDateController.text = DateFormat('dd-MM-yyyy').format(date);
    emit(CreateCampaignInitial());
  }

  void onEndDateSelected(DateTime date) {
    if (startDate==null) {
      emit(CreateCampaignFailure('please_select_start_date_first'));
      return;
    }
    if (startDate != null && date.isBefore(startDate!)) {
      emit(CreateCampaignFailure( 'end_date_cannot_be_before_start_date'));
      return;
    }

    endDate = date;
    endDateController.text = DateFormat('dd-MM-yyyy').format(date);
    emit(CreateCampaignInitial());
  }

  Future<void> submitForm(BuildContext context) async {
    /// HERE: Validate Form Fields From UI
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (donationTypeId == '-1' || donationTypeId.isEmpty) {
      emit(CreateCampaignFailure('select_donation_type'));
      return;
    }
    if (eCardIdController.text.isEmpty) {
      emit(CreateCampaignFailure('please_select_e_card_design'));
      return;
    }

    emit(CreateCampaignLoading());

    final request = DonationCampaignRequestModel(
      name: nameController.text.trim(),
      mobileNumber: mobileNumber,
      email: emailController.text.trim(),
      campaignName: campaignNameController.text.trim(),
      startDate: startDateController.text.trim(),
      endDate: endDateController.text.trim(),
      donationTypeId: donationTypeId,
      message: messageController.text.trim(),
      eCardId: eCardIdController.text.trim(),
    );

    final result = await _dataSource.createDonationCampaign(request);

    result.fold(
      (failure) => emit(CreateCampaignFailure(failure.errMessage)),
      (_) => emit(CreateCampaignSuccess()),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    campaignNameController.dispose();
    messageController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    eCardIdController.dispose();
    return super.close();
  }
}
