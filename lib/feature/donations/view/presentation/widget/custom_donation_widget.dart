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

class DonationModel {
  final String title;
  final String description;
  final String imagePath;
  final double raised;
  final double goal;
  final String nameDonation;
  final Color colorDonation;

  DonationModel({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.raised,
    required this.goal,
    required this.nameDonation,
    required this.colorDonation,
  });
}

class DonationsWidget extends StatelessWidget {
  final String nameTittle;
  final List<DonationModel> donations;

  const DonationsWidget({super.key, required this.nameTittle, required this.donations});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SeeAllWidget(title: nameTittle.tr()),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [...List.generate(donations.length, (index) => ItemDonationsWidget(donation: donations[index]))]),
        ),
      ],
    );
  }
}

class ItemDonationsWidget extends StatefulWidget {
  final DonationModel donation;

  const ItemDonationsWidget({super.key, required this.donation});

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
                    urlImage: widget.donation.imagePath,
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                        decoration: BoxDecoration(color: widget.donation.colorDonation, borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppIcons.incidentsIc, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                            const SizedBox(width: 4),
                            Text(
                              widget.donation.nameDonation.tr(),
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.white),
                            ),
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
                  Text(widget.donation.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('raised'.tr(), style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.cRed900)),
                          const SizedBox(height: 6),
                          Text('${widget.donation.raised}${'JOD'.tr()}'.tr(), style: Theme.of(context).textTheme.displayMedium),
                          const SizedBox(height: 4),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('goal'.tr(), style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.cRed900)),
                          const SizedBox(height: 6),
                          Text('${widget.donation.goal} ${'JOD'.tr()}'.tr(), style: Theme.of(context).textTheme.displayMedium),
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
                          widget.donation.description,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
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
