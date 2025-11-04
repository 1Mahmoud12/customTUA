import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/feature/donationHistory/view/presentation/widgets/show_details_donation_dialog.dart';

class ItemDonationHistoryWidget extends StatelessWidget {
  const ItemDonationHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDetailsDonationDialog(context, onPress: () {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.cBorderButtonColor))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CacheImage(urlImage: '', width: 70, height: 70, fit: BoxFit.fill, borderRadius: 16),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'To our children in Jordan & Gaza',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('30 ${'JOD'.tr()}', style: Theme.of(context).textTheme.displayMedium),
                      const Spacer(),
                      //2024-05-24   |   16:19
                      Text(
                        DateFormat('yyyy-MM-dd | HH:mm').format(DateTime.now()),
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50.withAlpha((.50 * 255).toInt())),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CustomTextButton(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        onPress: () {
                          showDetailsDonationDialog(context, onPress: () {});
                        },
                        childText: 'view_details'.tr(),
                      ),
                      const Spacer(),
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
