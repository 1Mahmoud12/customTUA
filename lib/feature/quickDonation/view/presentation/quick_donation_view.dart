import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/custom_switch_button.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/quickDonation/view/presentation/card_view.dart';

import '../../../donationsDetails/view/presentation/widgets/item_option_widget.dart'
    show ItemOptionsWidget;

class QuickDonationView extends StatefulWidget {
  const QuickDonationView({super.key});

  @override
  State<QuickDonationView> createState() => _QuickDonationViewState();
}

class _QuickDonationViewState extends State<QuickDonationView> {
  int? selectedAmount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'quick_donation'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),

        children: [
          CustomSwitchButton(
            items: [
              SwitchButtonModel(title: 'give_once', id: 1),
              SwitchButtonModel(title: 'monthly', id: 2),
            ],
            onChange: (value) {},
            initialIndex: 1,
          ),
          Text(
            'choose_the_amount'.tr(),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400),
          ),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.spaceBetween,
                  children:
                      [50, 100, 200, 500, 1000].map((option) {
                        return ItemOptionsWidget(
                          option: option,
                          onTap: (selected) {
                            setState(() {
                              selectedAmount = selected;
                            });
                          },
                          isSelected: selectedAmount == option, // highlight selected
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
          CustomTextFormField(
            controller: TextEditingController(),
            hintText: '',
            nameField: 'amount_value',
            textInputType: TextInputType.number,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('jod'.tr(), style: Theme.of(context).textTheme.displayMedium),
            ),
          ),
          InkWell(
            onTap: () {
              context.navigateToPage(
                const CardView(),
                pageTransitionType: PageTransitionType.rightToLeft,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.black100),
                  bottom: BorderSide(width: 1, color: AppColors.black100),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.giftIc),
                  const SizedBox(width: 8),
                  Text(
                    'send_as_an_e_card'.tr(),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.cP50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            'this_donation_will_be_allocated_to_support_families_in_need'.tr(),
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ].paddingDirectional(top: 16),
      ),
      persistentFooterButtons: [
        Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(width: 1, color: AppColors.black100)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomTextButton(
                  onPress: () {},
                  borderColor: AppColors.cRed900,
                  borderWidth: 2,
                  colorText: AppColors.white,
                  backgroundColor: AppColors.cRed900,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppIcons.unSelectedDonationIc,
                        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'donate'.tr(),
                        style: Theme.of(
                          context,
                        ).textTheme.displayMedium?.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: AppColors.cP50),
                ),

                child: SvgPicture.asset(AppIcons.cartIc),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
