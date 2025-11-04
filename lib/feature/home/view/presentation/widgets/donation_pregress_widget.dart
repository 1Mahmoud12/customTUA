import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/core/component/sliders/slider_custom.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/donationsDetails/view/presentation/donation_details_view.dart';

class DonationsProgressWidget extends StatelessWidget {
  const DonationsProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SeeAllWidget(title: 'donation_progress', padding: EdgeInsets.zero, showSeeAll: false),
          const SizedBox(height: 8),
          ...List.generate(5, (index) => const ItemDonateProgressWidget()),
        ],
      ),
    );
  }
}

class ItemDonateProgressWidget extends StatelessWidget {
  const ItemDonateProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.navigateToPage(const DonationDetailsView());
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.cBorderButtonColor))),
        child: Row(
          children: [
            const CacheImage(urlImage: '', width: 100, height: 110, fit: BoxFit.fill, borderRadius: 16),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text('To our children in Jordan & Gaza', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
                  const SizedBox(height: 4),
                  const SliderCustom(valueSlider: 30),
                  // const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('3,483 ${'jod'.tr()}', style: Theme.of(context).textTheme.displayMedium),
                      const Spacer(),
                      Text('3,483 ${'jod'.tr()}', style: Theme.of(context).textTheme.displayMedium),
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
