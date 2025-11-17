import 'package:flutter/material.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/donations/data/models/donation_program_model.dart';

import '../../../../../core/component/cache_image.dart';
import '../../../../../core/component/sliders/slider_custom.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../donationsDetails/view/presentation/donation_details_view.dart';

class ItemDonateProgressWidget extends StatelessWidget {
  const ItemDonateProgressWidget({super.key, required this.donation});

  final DonationProgramModel donation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.navigateToPage(DonationDetailsView(id: donation.id));
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.cBorderButtonColor))),
        child: Row(
          children: [
            CacheImage(urlImage: donation.image, width: 100, height: 110, fit: BoxFit.fill, borderRadius: 16),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(donation.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
                  const SizedBox(height: 4),
                  if (donation.progress < 100) SliderCustom(valueSlider: donation.progress.toDouble() < 0 ? 0 : donation.progress.toDouble()),
                  // const SizedBox(height: 8),
                  if (donation.raised != '' && donation.goal != '')
                    Row(
                      children: [
                        Text(donation.raised, style: Theme.of(context).textTheme.displayMedium),
                        const Spacer(),
                        Text(donation.goal, style: Theme.of(context).textTheme.displayMedium),
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
