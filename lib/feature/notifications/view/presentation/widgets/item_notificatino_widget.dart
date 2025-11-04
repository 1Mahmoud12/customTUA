import 'package:flutter/material.dart';
import 'package:tua/core/themes/colors.dart';

class ItemNotificationWidget extends StatelessWidget {
  const ItemNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.cBorderButtonColor))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('title', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
              Text(
                '12:00',
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP50.withAlpha((0.5 * 255).toInt())),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'description',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP50.withAlpha((0.5 * 255).toInt())),
          ),
        ],
      ),
    );
  }
}
