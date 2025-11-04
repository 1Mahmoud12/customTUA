import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_divider_widget.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_images.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';
import 'package:tua/feature/udhiyah/view/presentatioin/widgets/item_happy_eid_widget.dart';

import '../../../../core/component/custom_app_bar.dart' show customAppBar;

class SuccessUdhiyahView extends StatelessWidget {
  const SuccessUdhiyahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'check_your_udhiyah'),
      body: ListView(
        children: [
          Image.asset(AppImages.checkUdhiyah),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cBackGroundButtonColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.greyBorderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'happy_eid!'.tr(),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400, color: AppColors.cP50),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'your_udhiyah_was_performed_successfully!'.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cHumanitarianAidColor),
                      ),
                    ],
                  ),
                ),
                const CustomDividerWidget(),
                const ItemHappyEidWidget(title: 'receipt_number', value: '2024-123456'),
                const ItemHappyEidWidget(title: 'status', value: 'performed'),
                const ItemHappyEidWidget(title: 'receipt_number', value: '2024-123456', endValue: true),
              ],
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.cBorderButtonColor))),
          child: CustomTextButton(
            onPress: () {
              context.navigateToPageWithReplacement(const NavigationView(customIndex: 0));
            },
            childText: 'back_to_main_screen',
          ),
        ),
      ],
    );
  }
}
