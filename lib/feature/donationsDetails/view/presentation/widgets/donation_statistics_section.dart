import 'package:flutter/material.dart';

import '../../../../../core/utils/app_icons.dart';
import '../../../../donations/data/models/donation_program_details_model.dart';
import 'archive_goal_widget.dart';
import 'live_tracker_widget.dart';
import 'number_of_widget.dart';

class DonationStatisticsSection extends StatelessWidget {
  final DonationProgramDetailsModel detailsModel;

  const DonationStatisticsSection({super.key, required this.detailsModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ArchiveGoalWidget(),
        SizedBox(height: 10),
        LiveTrackerWidget(),
        SizedBox(height: 10),
        NumberOfWidget(
            nameImage: AppIcons.numberVisitIc,
            numbers: '20,100',
            numberOf: 'number_of_visits'),
        NumberOfWidget(
            nameImage: AppIcons.numberBeneficiariesIc,
            numbers: '20,100',
            numberOf: 'number_of_beneficiaries'),
        NumberOfWidget(
            nameImage: AppIcons.numberDonationsIc,
            numbers: '20,100',
            numberOf: 'number_of_donations'),
      ],
    );
  }
}
