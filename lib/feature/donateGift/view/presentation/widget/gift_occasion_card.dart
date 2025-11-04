import 'package:flutter/material.dart';
import 'package:tua/core/utils/constant_gaping.dart';

import '../../../../../core/component/cache_image.dart';

class GiftOccasionCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const GiftOccasionCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: CacheImage(urlImage: imageUrl, fit: BoxFit.fill),
        ),
        w5,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
              ),
              h5,
              Text(
                description,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
