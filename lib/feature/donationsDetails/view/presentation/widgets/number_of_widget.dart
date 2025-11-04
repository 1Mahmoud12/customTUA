import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/themes/colors.dart';

class NumberOfWidget extends StatelessWidget {
  final String nameImage;
  final String numbers;
  final String numberOf;

  const NumberOfWidget({super.key, required this.nameImage, required this.numbers, required this.numberOf});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.cP900),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(nameImage),
              const SizedBox(width: 10),
              Text(numbers, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          Text(numberOf.tr(), style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.neu700)),
        ],
      ),
    );
  }
}
