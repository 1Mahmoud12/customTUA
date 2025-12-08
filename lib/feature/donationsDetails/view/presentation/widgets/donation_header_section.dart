import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/hex_to_color.dart';
import '../../../../donations/data/models/donation_program_details_model.dart';
import 'image_donation_widget.dart';
import 'raised_goal_slider.dart';

class DonationHeaderSection extends StatelessWidget {
  final DonationProgramDetailsModel detailsModel;

  const DonationHeaderSection({super.key, required this.detailsModel});



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        ImageDonationWidget(
          nameTittle: detailsModel.tag?.tr() ?? '',
          image: detailsModel.image,
          color: detailsModel.color != null ? hexToColor(detailsModel.color!) : AppColors.cIncidentColor,
          edgeInsetsGeometry: EdgeInsets.zero,
        ),
        const SizedBox(height: 16),
        Text(
          detailsModel.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        if (detailsModel.goal != null && detailsModel.raised != null)
          RaisedAndGoalSliderWidget(goal: detailsModel.goal!, raised: detailsModel.raised!),
      ],
    );
  }
}
