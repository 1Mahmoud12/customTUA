import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/sliders/slider_custom.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';

class ItemProgramWidget extends StatelessWidget {
  const ItemProgramWidget({super.key, required this.color, required this.raised, required this.nameProgram, required this.iconProgram});

  final bool raised;
  final Color color;
  final String nameProgram;
  final String iconProgram;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * .8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.scaffoldBackGround,

        boxShadow: [BoxShadow(color: AppColors.greyG700.withAlpha((0.2 * 255).toInt()), blurRadius: 30, offset: const Offset(0, 20))],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                child: CacheImage(urlImage: '', width: double.infinity, height: 130.h, fit: BoxFit.cover, borderRadius: 0),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(iconProgram, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                          const SizedBox(width: 4),
                          Text(nameProgram.tr(), style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.white)),
                        ],
                      ),
                    ),
                    SvgPicture.asset(AppIcons.shareIc),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your zakat reaches Jordan & Gaza Gaza GazaGaza',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
                if (raised)
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('raised'.tr(), style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color)),
                          const SizedBox(height: 6),
                          Text('3,483 ${'JOD'.tr()}'.tr(), style: Theme.of(context).textTheme.displayMedium),
                          const SizedBox(height: 4),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('goal'.tr(), style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color)),
                          const SizedBox(height: 6),
                          Text('3,483 ${'JOD'.tr()}'.tr(), style: Theme.of(context).textTheme.displayMedium),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ],
                  ),
                if (raised) SliderCustom(valueSlider: 30, activeTrackColor: color),
                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomTextButton(
                        onPress: () {},
                        borderColor: AppColors.cRed900,
                        borderWidth: 2,
                        colorText: AppColors.white,
                        backgroundColor: AppColors.cRed900,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.unSelectedDonationIc, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                            const SizedBox(width: 8),
                            Text('donate'.tr(), style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.white)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1.5, color: AppColors.cP50)),

                      child: SvgPicture.asset(AppIcons.cartIc),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
