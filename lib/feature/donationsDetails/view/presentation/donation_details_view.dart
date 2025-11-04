import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/custom_check_box.dart';
import 'package:tua/core/component/custom_divider_widget.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/donations/view/presentation/add_person_view.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/archive_goal_widget.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/currency_widget.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/image_donation_widget.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/live_tracker_widget.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/number_of_widget.dart' show NumberOfWidget;
import 'package:tua/feature/donationsDetails/view/presentation/widgets/raised_goal_slider.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/related_story_widge.dart' show RelatedStoryWidget;
import 'package:tua/feature/donationsDetails/view/presentation/widgets/select_currency_widget.dart' show SelectCurrencyWidget;

import 'widgets/item_option_widget.dart';

class DonationDetailsView extends StatefulWidget {
  const DonationDetailsView({super.key});

  @override
  State<DonationDetailsView> createState() => _DonationDetailsViewState();
}

class _DonationDetailsViewState extends State<DonationDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'donation_details'),
      body: DefaultTabController(
        length: 3,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      ImageDonationWidget(nameTittle: 'Incidents', image: '', color: AppColors.cIncidentColor, edgeInsetsGeometry: EdgeInsets.zero),
                      const SizedBox(height: 16),
                      Text('Child to child', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      const RaisedAndGoalSliderWidget(goal: 10000, raised: 3400),

                      TabBar(
                        labelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: AppColors.cP50,
                        unselectedLabelStyle: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500, color: AppColors.cP50.withAlpha((.5 * 255).toInt())),
                        tabs: [Tab(text: 'description'.tr()), Tab(text: 'reports'.tr()), Tab(text: 'tab 3'.tr())],
                      ),
                      SizedBox(
                        height: 115,
                        child: TabBarView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'In a world where the smallest act of giving can leave a big impact.In a world where the smallest act of giving can leave a big impact.In a world where the smallest act of giving can leave a big impact.',
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Study report for this campaign',
                                    style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(52),
                                      border: Border.all(color: AppColors.cP100, width: 2),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'download_report'.tr(),
                                          style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50),
                                        ),
                                        const SizedBox(width: 8),

                                        SvgPicture.asset(AppIcons.downloadIc),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'In a world where the smallest act of giving can leave a big impact.In a world where the smallest act of giving can leave a big impact.In a world where the smallest act of giving can leave a big impact.',
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const CustomDividerWidget(height: 24),
                      const CurrencyWidget(),
                      const CustomDividerWidget(height: 20),
                      const SelectCurrencyWidget(),
                      const CustomDividerWidget(height: 20),

                      CustomCheckBox(
                        fillTrueValue: AppColors.cP50,
                        onTap: (value) {},
                        widthBorder: 1.5,
                        borderRadius: 4,
                        borderColor: AppColors.cP50,
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'I’d like to add 2.4% to help cover transaction fees for my donation.',
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomCheckBox(
                        borderRadius: 4,
                        widthBorder: 1.5,
                        fillTrueValue: AppColors.cP50,
                        borderColor: AppColors.cP50,
                        checkBox: true,
                        onTap: (value) {},
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'Donate as a gift and share the reward',
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextButton(
                        onPress: () {
                          context.navigateToPage(const AddPersonView());
                        },
                        childText: 'add_person',
                        backgroundColor: AppColors.white,
                        colorText: AppColors.green,
                        borderColor: AppColors.green,
                      ),
                      const SizedBox(height: 10),
                      const ArchiveGoalWidget(),
                      const SizedBox(height: 10),
                      const LiveTrackerWidget(),
                      const SizedBox(height: 10),
                      const CustomDividerWidget(height: 20),
                      const NumberOfWidget(nameImage: AppIcons.numberVisitIc, numbers: '20,100', numberOf: 'number_of_visits'),
                      const NumberOfWidget(nameImage: AppIcons.numberBeneficiariesIc, numbers: '20,100', numberOf: 'number_of_beneficiaries'),
                      const NumberOfWidget(nameImage: AppIcons.numberDonationsIc, numbers: '20,100', numberOf: 'number_of_donations'),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const RelatedStoryWidget(),
                SizedBox(height: 190.h),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                boxShadow: [BoxShadow(color: AppColors.cBorderButtonColor, blurRadius: 4, offset: Offset(2, -2))],
                color: AppColors.scaffoldBackGround,
                border: Border(top: BorderSide(color: AppColors.cBorderButtonColor)),
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            ItemOptionsWidget(option: 50, onTap: (option) {}),
                            ItemOptionsWidget(option: 100, onTap: (option) {}),
                            ItemOptionsWidget(option: 200, onTap: (option) {}),
                            ItemOptionsWidget(option: 500, onTap: (option) {}),
                            ItemOptionsWidget(option: 1000, onTap: (option) {}),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                    controller: TextEditingController(),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'jod'.tr(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w400),
                      ),
                    ),
                    hintText: 'enter_amount'.tr(),
                    textInputType: TextInputType.number,
                  ),
                  Row(
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
                              SvgPicture.asset(AppIcons.unSelectedDonationIc, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                              const SizedBox(width: 8),
                              Text('donate'.tr(), style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.white)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1.5, color: AppColors.cP50)),

                        child: SvgPicture.asset(AppIcons.cartIc),
                      ),
                    ],
                  ),
                ].paddingDirectional(bottom: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
