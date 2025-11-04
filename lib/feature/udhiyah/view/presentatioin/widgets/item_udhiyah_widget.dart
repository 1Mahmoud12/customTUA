import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/themes/colors.dart';

class ItemUdhiyahWidget extends StatelessWidget {
  final String title;

  const ItemUdhiyahWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          width: 5,
          height: 5,
          decoration: BoxDecoration(color: AppColors.black, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(title.tr(), style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500))),
      ],
    );
  }
}
