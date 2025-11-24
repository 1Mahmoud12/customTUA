import 'package:easy_localization/easy_localization.dart' as title;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_images.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/campagin/view/presentation/create_campaign_view.dart';
import 'package:tua/feature/quickDonation/view/presentation/quick_donation_view.dart';
import 'package:tua/feature/udhiyah/view/presentatioin/udhiyah_view.dart';
import 'package:tua/feature/zakatCalculator/view/presentation/zakat_calculator.dart';

class QuickTools extends StatelessWidget {
  const QuickTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SeeAllWidget(title: 'quick_tools', padding: EdgeInsets.zero, showSeeAll: false),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ItemQuickDonationWidget(
                  nameImage: AppImages.zakatCalculator,
                  title: 'zakat_calculator',
                  onTap: () {
                    context.navigateToPage(const ZakatCalculatorView());
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ItemQuickDonationWidget(
                  onTap: () {
                    context.navigateToPage(const QuickDonationView());
                  },
                  nameImage: AppImages.quickDonation,
                  title: 'quick_donations',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ItemQuickDonationWidget(
                  onTap: () {
                    // if (userCacheValue==null ) {
                    //   loginRequiredDialog(context);
                    //   return;
                    // }
                    context.navigateToPage(const CreateCampaignView());
                  },
                  nameImage: AppImages.createCampaign,
                  title: 'create_campaign',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ItemQuickDonationWidget(
            onTap: () {
              context.navigateToPage(const UdhiyahView());
            },
            nameImage: AppImages.udhiyah,
            title: 'check_your_udhyiah',
          ),
        ],
      ),
    );
  }
}

class ItemQuickDonationWidget extends StatelessWidget {
  const ItemQuickDonationWidget({super.key, required this.nameImage, required this.title, this.onTap});

  final String nameImage;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(border: Border.all(color: AppColors.cBorderButtonColor), borderRadius: BorderRadius.circular(16)),
        alignment: AlignmentDirectional.center,
        child: Column(
          children: [
            Image.asset(nameImage, width: 60, height: 60, fit: BoxFit.fill),
            const SizedBox(height: 10),
            SizedBox(
              width: 70.w,
              child: Text(
                title.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
