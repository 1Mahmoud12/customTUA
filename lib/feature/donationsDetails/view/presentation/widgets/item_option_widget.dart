import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/themes/colors.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/themes/colors.dart';

class ItemOptionsWidget extends StatelessWidget {
  final int option;
  final Function(int) onTap;
  final bool isSelected; // New
  final Color selectedTextColor;
  final Color unselectedTextColor;

  const ItemOptionsWidget({
    super.key,
    required this.option,
    required this.onTap,
    this.isSelected = false,
    this.selectedTextColor = AppColors.cP50,
    this.unselectedTextColor = AppColors.greyG500,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(option);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.cP50.withOpacity(0.1) // subtle background when selected
              : AppColors.cDonateCardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.cP50 : AppColors.cBorderButtonColor,
            width: 2,
          ),
        ),
        child: Text(
          '$option'.tr(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: isSelected ? selectedTextColor : unselectedTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
