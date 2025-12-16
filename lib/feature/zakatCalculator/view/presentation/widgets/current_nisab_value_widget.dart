import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';

import '../../../../../core/utils/constants_models.dart';

class CurrentNisabValueWidget extends StatelessWidget {
  const CurrentNisabValueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),

        boxShadow: [BoxShadow(color: AppColors.cShadowColor.withAlpha((0.2 * 255).toInt()), blurRadius: 40, offset: Offset.zero)],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.currentNisabValueIc),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('current_nisab_value'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
              const SizedBox(height: 4),
              Text(
                '${ConstantsModels.lookupModel?.data?.zakatCalculation?.nisab??''}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
