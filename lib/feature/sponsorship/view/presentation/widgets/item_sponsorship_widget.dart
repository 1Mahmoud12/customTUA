import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/sponsorship/view/presentation/request_call_view.dart';
import 'package:tua/feature/sponsorship/view/presentation/request_visit_view.dart';

class ItemSponsorshipWidget extends StatelessWidget {
  const ItemSponsorshipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.cBorderButtonColor))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CacheImage(urlImage: '', width: 70, height: 70, fit: BoxFit.cover),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ahmed', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${'age'.tr()}: ', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
                    Text('20 ${'years_old'.tr()}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${'donor_user'.tr()}: ', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'ahmed mohamed',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text('${'donation_amount'.tr()}: ', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '20000 ${'jod'.tr()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${'gender'.tr()}: ', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
                              Text('female'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
                            ],
                          ),
                          Text(
                            'monthly'.tr(),
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(color: AppColors.cP50.withAlpha((.5 * 255).toInt()), fontWeight: FontWeight.w400),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextButton(
                        onPress: () {
                          context.navigateToPage(const RequestVisitView());
                        },
                        isExpand: false,
                        backgroundColor: AppColors.white,
                        borderColor: AppColors.cP50,
                        colorText: AppColors.cP50,
                        childText: 'request_visit'.tr(),
                        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .04, vertical: context.screenWidth * .03),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: CustomTextButton(
                        onPress: () {
                          context.navigateToPage(const RequestCallView());
                        },
                        isExpand: false,
                        childText: 'request_call'.tr(),
                        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .04, vertical: context.screenWidth * .03),
                      ),
                    ),
                  ],
                ),
              ].paddingDirectional(bottom: 8),
            ),
          ),
        ],
      ),
    );
  }
}
