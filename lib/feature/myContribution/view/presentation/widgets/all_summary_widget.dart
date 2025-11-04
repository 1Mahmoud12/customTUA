import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/extensions.dart';

class AllSummaryWidget extends StatelessWidget {
  const AllSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cBackGroundButtonColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cP50.withAlpha((0.2 * 255).toInt())),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...List.generate(10, (index) => const ItemAllSummaryWidget())].paddingDirectional(bottom: 8),
      ),
    );
  }
}

class ItemAllSummaryWidget extends StatelessWidget {
  const ItemAllSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.cP50, shape: BoxShape.circle)),
            const SizedBox(width: 10),
            Text('${'children'.tr()}: ', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
          ],
        ),

        Text('12', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
