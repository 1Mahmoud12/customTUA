import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tua/core/themes/colors.dart';

class ItemProfileWidget extends StatelessWidget {
  const ItemProfileWidget({super.key, required this.name, required this.image, this.onTap, this.widget});

  final String name;
  final Function()? onTap;
  final String image;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(border: Border.all(color: AppColors.greyBorderColor), borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            RotatedBox(quarterTurns: name == 'logout' ? (context.locale.languageCode == 'ar' ? 2 : 0) : 0, child: SvgPicture.asset(image)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: name == 'logout' ? AppColors.cError300 : AppColors.cP50, fontWeight: FontWeight.w500),
              ),
            ),
            if (widget != null) widget!,
          ],
        ),
      ),
    );
  }
}
