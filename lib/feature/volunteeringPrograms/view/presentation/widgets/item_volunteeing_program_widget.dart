import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/application_form_view.dart';
import 'package:tua/feature/volunteeringPrograms/view/presentation/details_volunteering_view.dart';

class ItemVolunteeringProgramsWidget extends StatelessWidget {
  final bool widthImage;

  const ItemVolunteeringProgramsWidget({super.key, this.widthImage = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.navigateToPage(const DetailsVolunteeringView());
      },
      child: Container(
        width: widthImage ? context.screenWidth * .8 : null,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(14), bottomLeft: Radius.circular(14)),

          boxShadow: [BoxShadow(color: Color(0x33B6B6B6), blurRadius: 30, offset: Offset(0, 20), spreadRadius: 0)],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
              child: CacheImage(urlImage: '', width: double.infinity, height: context.screenHeight * .25, fit: BoxFit.cover, borderRadius: 0),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Food parcel packaging programs', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Text(
                    'Our monthly food parcels offer a variety of fresh, high-quality ingredients to spark creativity in the kitchen and simplify meal planning.',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextButton(
                          onPress: () {
                            context.navigateToPage(const ApplicationFormView());
                          },
                          childText: 'apply_now',
                        ),
                      ),
                      const SizedBox(width: 12),
                      CustomTextButton(
                        onPress: () {},
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        borderColor: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor),
                          child: SvgPicture.asset(AppIcons.customShareIc),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
