import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/themes/colors.dart';

class ItemOptionsWidget extends StatelessWidget {
  final int option;
  final Color textColor;
  final Function(int) onTap;

  const ItemOptionsWidget({super.key, required this.option, required this.onTap, this.textColor = AppColors.greyG500});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(option);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: AppColors.cDonateCardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.cBorderButtonColor, width: 2),
        ),
        child: Text('$option'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: textColor, fontWeight: FontWeight.w400)),
      ),
    );
  }
}
