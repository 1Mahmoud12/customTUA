import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/themes/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<String> selectedIcons;
  final List<String> unselectedIcons;
  final List<String> names;
  final bool showBadge;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.selectedIcons,
    required this.names,
    required this.unselectedIcons,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: Platform.isIOS ? 30 : 0),
      decoration: const BoxDecoration(color: AppColors.white, border: Border(top: BorderSide(color: AppColors.cBorderButtonColor))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          4,
          (index) => _buildNavItem(
            context: context,
            index: index,
            isSelected: currentIndex == index,
            showBadge: showBadge && index == 3, // Example for campaign tab
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required BuildContext context, required int index, required bool isSelected, bool showBadge = false}) {
    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showBadge)
              Badge(
                isLabelVisible: false,
                smallSize: 10,
                backgroundColor: AppColors.red,
                child: SvgPicture.asset(isSelected ? selectedIcons[index] : unselectedIcons[index]),
              )
            else
              SvgPicture.asset(isSelected ? selectedIcons[index] : unselectedIcons[index]),
            Text(
              names[index].tr(),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: isSelected ? AppColors.black400 : AppColors.greyG300),
            ),
          ],
        ),
      ),
    );
  }
}
