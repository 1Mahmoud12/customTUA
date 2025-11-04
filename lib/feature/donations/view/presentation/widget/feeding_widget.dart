import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/donationsDetails/view/presentation/donation_details_view.dart';

class FeedingWidget extends StatelessWidget {
  const FeedingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SeeAllWidget(title: 'feeding'.tr()),
        const SizedBox(height: 16),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [...List.generate(3, (index) => const ItemFeedingWidget())])),
      ],
    );
  }
}

class ItemFeedingWidget extends StatefulWidget {
  const ItemFeedingWidget({super.key});

  @override
  State<ItemFeedingWidget> createState() => _ItemFeedingWidgetState();
}

class _ItemFeedingWidgetState extends State<ItemFeedingWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.navigateToPage(const DonationDetailsView());
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: context.screenWidth * .8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.scaffoldBackGround,

          boxShadow: [BoxShadow(color: AppColors.cShadowColor.withAlpha((0.2 * 255).toInt()), blurRadius: 30, offset: const Offset(0, 20))],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  child: CacheImage(
                    urlImage: 'widget.donation.imagePath',
                    width: context.screenWidth * .8,
                    height: 160.h,
                    fit: BoxFit.cover,
                    borderRadius: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                          decoration: BoxDecoration(color: AppColors.cFeedingColor, borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AppIcons.feedingIc, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'feeding'.tr(),
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.white),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
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
                  Text('widget.donation.title', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  Text(
                    'Our monthly food parcels offer a variety of fresh, high-quality ingredients to spark creativity in the kitchen and simplify meal planning.',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500, color: AppColors.cP50.withAlpha((.5 * 255).toInt())),
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
