import 'package:flutter/material.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/themes/colors.dart';

class DonateCard extends StatelessWidget {
  final String englishTitle;
  final String imageUrl;
  final bool isSelected;
  final VoidCallback? onTap;
  final int? value;
  final int? groupValue;

  const DonateCard({super.key, required this.englishTitle, required this.imageUrl, this.isSelected = false, this.onTap, this.value, this.groupValue});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 169,
        height: 246,
        decoration: BoxDecoration(
          color: AppColors.cDonateCardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.cBorderButtonColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 156,
              decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),

              child: CacheImage(urlImage: imageUrl, fit: BoxFit.fill),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(
                englishTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cRadioColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Radio(value: value, groupValue: groupValue, onChanged: (_) => onTap?.call(), activeColor: AppColors.cRadioColor),
            ),
          ],
        ),
      ),
    );
  }
}
