import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';

class ArchiveGoalWidget extends StatelessWidget {
  const ArchiveGoalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(color: AppColors.cW50, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SvgPicture.asset(AppIcons.archiveGoalIc),
          const SizedBox(height: 20),
          Text(
            'together_we_achieved_the_goal!'.tr(),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'This campaign successfully reached its target on 11/11/2024, thanks to your generous support and contributions!'.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.cP50.withAlpha((.5 * 255).toInt())),
          ),
        ],
      ),
    );
  }
}
