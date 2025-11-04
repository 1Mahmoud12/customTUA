import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/see_all_widget.dart';
import 'package:tua/core/component/sliders/slider_custom.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/donationsDetails/view/presentation/donation_details_view.dart';

class QuickDonations extends StatelessWidget {
  const QuickDonations({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackGround,
      child: Column(
        children: [
          const SeeAllWidget(title: 'quick_donations'),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [...List.generate(10, (index) => const ItemDonationsWidget())]),
          ),
        ],
      ),
    );
  }
}

class ItemDonationsWidget extends StatefulWidget {
  const ItemDonationsWidget({super.key});

  @override
  State<ItemDonationsWidget> createState() => _ItemDonationsWidgetState();
}

class _ItemDonationsWidgetState extends State<ItemDonationsWidget> {
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
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.scaffoldBackGround,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          shadows: const [BoxShadow(color: Color(0x33B6B6B6), blurRadius: 30, offset: Offset(0, 20), spreadRadius: 0)],
        ),

        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  child: CacheImage(urlImage: '', width: double.infinity, height: 160.h, fit: BoxFit.cover, borderRadius: 0),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                        decoration: BoxDecoration(color: AppColors.cRed900, borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppIcons.incidentsIc, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                            const SizedBox(width: 4),
                            Text('Incidents', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.white)),
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
                  Text('Your zakat reaches Jordan & Gaza', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('raised'.tr(), style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.cRed900)),
                          const SizedBox(height: 6),
                          Text('3,483 ${'JOD'.tr()}'.tr(), style: Theme.of(context).textTheme.displayMedium),
                          const SizedBox(height: 4),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('goal'.tr(), style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.cRed900)),
                          const SizedBox(height: 6),
                          Text('3,483 ${'JOD'.tr()}'.tr(), style: Theme.of(context).textTheme.displayMedium),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ],
                  ),
                  const SliderCustom(valueSlider: 30),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Donations collected. Review the campaign report',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SvgPicture.asset(AppIcons.downloadIc),
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
