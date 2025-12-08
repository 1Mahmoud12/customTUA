import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';

class ImageDonationWidget extends StatelessWidget {
  final String nameTittle;
  final String? image;
  final Color? color;
  final EdgeInsetsGeometry? edgeInsetsGeometry;

  const ImageDonationWidget({super.key, required this.nameTittle, this.image, this.color, this.edgeInsetsGeometry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsetsGeometry ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          CacheImage(urlImage: image, width: context.screenWidth, height: context.screenHeight * .25),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(color:color, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppIcons.incidentsIc, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                  const SizedBox(width: 4),
                  Text(nameTittle, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
