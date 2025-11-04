import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/themes/colors.dart';

class ForMoneyWidget extends StatelessWidget {
  const ForMoneyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),

        boxShadow: [BoxShadow(color: AppColors.cShadowColor.withAlpha((0.2 * 255).toInt()), blurRadius: 40)],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${'for_money'.tr()}: ', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
          const SizedBox(height: 12),
          Text(
            'Zakat on cash becomes obligatory when the amount of cash, whether held in bank or on hand fulfills Nisab. It also  includes  money held  in retirement  and  pension  accounts. The  percentage  of  Nisab  that  is payable as Zakat is a quarter of one-tenth (2.5%) of the total money of his/her ownership after one lunar year.',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP50.withAlpha((0.5 * 255).toInt())),
          ),
        ],
      ),
    );
  }
}
