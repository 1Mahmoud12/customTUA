import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';

class FiltersWidget extends StatelessWidget {
  final int selectedFilter;
  final Function(int)? onTap;

  const FiltersWidget({super.key, required this.selectedFilter, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ItemFilterWidget(title: 'all', isSelected: selectedFilter == 0, onTap: () => onTap?.call(0)),
        ItemFilterWidget(nameImage: AppIcons.feedingIc, title: 'feeding', isSelected: selectedFilter == 1, onTap: () => onTap?.call(1)),
        ItemFilterWidget(nameImage: AppIcons.incidentsIc, title: 'incidents', isSelected: selectedFilter == 2, onTap: () => onTap?.call(2)),
        ItemFilterWidget(nameImage: AppIcons.volunteeringIc, title: 'volunteering', isSelected: selectedFilter == 3, onTap: () => onTap?.call(3)),
        ItemFilterWidget(
          nameImage: AppIcons.humanitarianAidIc,
          title: 'humanitarian_aid',
          isSelected: selectedFilter == 4,
          onTap: () => onTap?.call(4),
        ),
      ],
    );
  }
}

class ItemFilterWidget extends StatelessWidget {
  final String? nameImage;
  final Function? onTap;
  final String title;
  final bool isSelected;

  const ItemFilterWidget({super.key, this.nameImage, required this.title, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.cBorderButtonColor),
          color: isSelected ? AppColors.primaryColor : AppColors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (nameImage != null)
              SvgPicture.asset(
                nameImage!,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(isSelected ? AppColors.white : AppColors.greyG500, BlendMode.srcIn),
              ),
            if (nameImage != null) const SizedBox(width: 8),
            Text(
              title.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400, color: isSelected ? AppColors.white : AppColors.greyG500),
            ),
          ],
        ),
      ),
    );
  }
}
