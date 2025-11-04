import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/programs/view/presentation/feeding_programs_view.dart';
import 'package:tua/feature/programs/view/presentation/humanitarian_aid_programs_view.dart';
import 'package:tua/feature/programs/view/presentation/incidents_programs_view.dart';
import 'package:tua/feature/programs/view/presentation/ramadan_campaign_programs_view.dart';

class OurProgramsWidget extends StatelessWidget {
  const OurProgramsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('our_programs'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Row(
            children: [
              ItemProgramWidget(
                nameItem: 'Incidents',
                nameImage: AppIcons.incidentsIc,
                colorItem: AppColors.cIncidentColor.withAlpha((.1 * 255).toInt()),
                onTap: () {
                  context.navigateToPage(const IncidentsProgramsView());
                },
              ),
              const SizedBox(width: 8),
              ItemProgramWidget(
                nameItem: 'Feeding',
                nameImage: AppIcons.feedingIc,
                colorItem: AppColors.cFeedingColor.withAlpha((.1 * 255).toInt()),
                onTap: () {
                  context.navigateToPage(const FeedingProgramsView());
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ItemProgramWidget(
                nameItem: 'Humanitarian aid',
                nameImage: AppIcons.humanitarianAidIc,
                colorItem: AppColors.cHumanitarianAidColor.withAlpha((.1 * 255).toInt()),
                onTap: () {
                  context.navigateToPage(const HumanitarianAidView());
                },
              ),
              const SizedBox(width: 8),
              ItemProgramWidget(
                nameItem: 'Ramadan campaigns',
                nameImage: AppIcons.ramadanCampaignsIc,
                colorItem: AppColors.cRamadanCampaignsColor.withAlpha((.1 * 255).toInt()),
                onTap: () {
                  context.navigateToPage(const RamadanCampaignProgramsView());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemProgramWidget extends StatelessWidget {
  const ItemProgramWidget({super.key, required this.nameItem, required this.nameImage, required this.colorItem, this.onTap});

  final String nameItem;
  final String nameImage;
  final Color colorItem;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // width: context.screenWidth * .44,
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(56), color: colorItem),
              child: SvgPicture.asset(nameImage),
            ),
            const SizedBox(height: 10),
            Text(nameItem.tr(), style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
