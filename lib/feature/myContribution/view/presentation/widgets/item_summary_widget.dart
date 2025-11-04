import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/extensions.dart';

class ItemSummaryWidget extends StatelessWidget {
  const ItemSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cBackGroundButtonColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cP50.withAlpha((0.2 * 255).toInt())),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('I contributed today'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                Text(
                  'Feeding 12 persons'.tr(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.greyG500, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.cFeedingColor, shape: BoxShape.circle)),
                        const SizedBox(width: 10),
                        Text('${'children'.tr()}: ', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
                      ],
                    ),

                    Text('12', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.cFeedingColor, shape: BoxShape.circle)),
                        const SizedBox(width: 10),
                        Text('${'children'.tr()}: ', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
                      ],
                    ),

                    Text('12', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.cFeedingColor, shape: BoxShape.circle)),
                        const SizedBox(width: 10),
                        Text('${'children'.tr()}: ', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
                      ],
                    ),

                    Text('12', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
              ].paddingDirectional(bottom: 8),
            ),
          ),
          const SizedBox(width: 24),
          SizedBox(
            width: 110.w,
            height: 100.h,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(value: 50, color: AppColors.cFeedingColor, radius: 10, showTitle: false),
                      PieChartSectionData(value: 20, color: AppColors.cIncidentColor, radius: 10, showTitle: false),
                      PieChartSectionData(value: 30, color: AppColors.cRamadanCampaignsColor, radius: 10, showTitle: false),
                    ],
                    sectionsSpace: 0,
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: FittedBox(
                    child: Text('12 ${'persons'.tr()}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
