import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';

class LiveTrackerWidget extends StatelessWidget {
  const LiveTrackerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('live_tracker'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),

        const IntrinsicHeight(
          child: Row(
            children: [
              ItemLiveTrackerWidget(image: AppIcons.waterproofJacketIc, title: 'waterproof_jacket', number: '100'),
              ItemLiveTrackerWidget(image: AppIcons.schoolBackpackIc, title: 'school_backpack', number: '100'),
              ItemLiveTrackerWidget(image: AppIcons.foodPacelIc, title: 'food_pacel', number: '100'),
            ],
          ),
        ),
      ],
    );
  }
}

class ItemLiveTrackerWidget extends StatelessWidget {
  const ItemLiveTrackerWidget({super.key, required this.image, required this.title, required this.number});

  final String image;
  final String title;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.cW50),
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(image),
            const SizedBox(height: 8),
            Text(title.tr(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text(
              number,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500, color: AppColors.cHumanitarianAidColor),
            ),
          ],
        ),
      ),
    );
  }
}
