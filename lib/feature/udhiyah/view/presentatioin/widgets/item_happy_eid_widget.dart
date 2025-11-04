import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/themes/colors.dart';

class ItemHappyEidWidget extends StatelessWidget {
  const ItemHappyEidWidget({super.key, required this.title, required this.value, this.endValue = false});

  final String title;
  final String value;
  final bool endValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: endValue ? AppColors.transparent : AppColors.cP50.withAlpha((0.2 * 255).toInt()))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${title.tr()}:',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
