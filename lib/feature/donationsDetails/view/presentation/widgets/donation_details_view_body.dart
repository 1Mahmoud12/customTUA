import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/extensions.dart';
import 'package:tua/feature/cart/data/models/add_cart_item_parms.dart';
import 'package:tua/feature/donations/data/models/donation_program_details_model.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/donation_button.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/image_donation_widget.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/raised_goal_slider.dart';
import 'package:tua/feature/donationsDetails/view/presentation/widgets/related_story_widge.dart' show RelatedStoryWidget;

import 'item_option_widget.dart';

class DonationDetailsViewBody extends StatefulWidget {
  const DonationDetailsViewBody({super.key, required this.detailsModel});

  final DonationProgramDetailsModel detailsModel;

  @override
  State<DonationDetailsViewBody> createState() => _DonationDetailsViewBodyState();
}

class _DonationDetailsViewBodyState extends State<DonationDetailsViewBody> {
  int? selectedAmount;
  String? selectedCurrency;
  TextEditingController amountController = TextEditingController();

  String stripHtmlTags(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.detailsModel.tabs?.length ?? 0,
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
                    ImageDonationWidget(
                      nameTittle: widget.detailsModel.tag ?? '',
                      image: widget.detailsModel.image,
                      color: AppColors.cIncidentColor,
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 16),
                    Text(widget.detailsModel.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    if (widget.detailsModel.goal != null && widget.detailsModel.raised != null)
                      RaisedAndGoalSliderWidget(goal: widget.detailsModel.goal!, raised: widget.detailsModel.raised!),
                    TabBar(
                      labelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: AppColors.cP50,
                      unselectedLabelStyle: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500, color: AppColors.cP50.withAlpha((.5 * 255).toInt())),
                      tabs: widget.detailsModel.tabs?.map((e) => Tab(text: e.title)).toList() ?? [],
                    ),
                    SizedBox(
                      height: 200,
                      child: TabBarView(
                        children:
                            widget.detailsModel.tabs?.map((tab) {
                              // If this tab has a report URL, show a download section
                              if (tab.labelUrl != null && tab.labelUrl!.isNotEmpty) {
                                return Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        tab.title,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.displayMedium?.copyWith(color: AppColors.cP50, fontWeight: FontWeight.w500),
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
                                );
                              }

                              // Otherwise, show the tab description text
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  stripHtmlTags(tab.brief ?? ''),
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50),
                                ),
                              );
                            }).toList() ??
                            [],
                      ),
                    ),

                    // const CustomDividerWidget(height: 24),
                    // CurrencyWidget(
                    //   details: widget.detailsModel,
                    //   onChange: (selectedKey) {
                    //     print('Selected recurring type: $selectedKey');
                    //     selectedCurrency = selectedKey;
                    //     setState(() {});
                    //
                    //     // Example output: "once", "monthly", "yearly"
                    //   },
                    // ),
                    // const CustomDividerWidget(height: 20),
                    // const SelectCurrencyWidget(),
                    // const CustomDividerWidget(height: 20),
                    //
                    // CustomCheckBox(
                    //   fillTrueValue: AppColors.cP50,
                    //   onTap: (value) {},
                    //   widthBorder: 1.5,
                    //   borderRadius: 4,
                    //   borderColor: AppColors.cP50,
                    //   child: Expanded(
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //       child: Text(
                    //         'I’d like to add 2.4% to help cover transaction fees for my donation.',
                    //         style: Theme.of(
                    //           context,
                    //         ).textTheme.displayMedium?.copyWith(color: AppColors.cP50),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    // CustomCheckBox(
                    //   borderRadius: 4,
                    //   widthBorder: 1.5,
                    //   fillTrueValue: AppColors.cP50,
                    //   borderColor: AppColors.cP50,
                    //   checkBox: true,
                    //   onTap: (value) {},
                    //   child: Expanded(
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //       child: Text(
                    //         'Donate as a gift and share the reward',
                    //         style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.cP50),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    // CustomTextButton(
                    //   onPress: () {
                    //     context.navigateToPage(const AddPersonView());
                    //   },
                    //   childText: 'add_person',
                    //   backgroundColor: AppColors.white,
                    //   colorText: AppColors.green,
                    //   borderColor: AppColors.green,
                    // ),
                    // const SizedBox(height: 10),
                    // const ArchiveGoalWidget(),
                    // const SizedBox(height: 10),
                    // const LiveTrackerWidget(),
                    // const SizedBox(height: 10),
                    // const CustomDividerWidget(height: 20),
                    // const NumberOfWidget(nameImage: AppIcons.numberVisitIc, numbers: '20,100', numberOf: 'number_of_visits'),
                    // const NumberOfWidget(nameImage: AppIcons.numberBeneficiariesIc, numbers: '20,100', numberOf: 'number_of_beneficiaries'),
                    // const NumberOfWidget(nameImage: AppIcons.numberDonationsIc, numbers: '20,100', numberOf: 'number_of_donations'),
                    // const SizedBox(height: 20),
                  ],
                ),
              ),
              if (widget.detailsModel.relatedDonationPrograms != null && widget.detailsModel.relatedDonationPrograms!.isNotEmpty)
                RelatedStoryWidget(relatedPrograms: widget.detailsModel.relatedDonationPrograms!),
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
                        children:
                            [50, 100, 200, 500, 1000].map((option) {
                              return ItemOptionsWidget(
                                option: option,
                                onTap: (selected) {
                                  setState(() {
                                    selectedAmount = selected;
                                    amountController.text = selected.toString();
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
                  controller: amountController,
                  onChange: (value) {
                    setState(() {
                      selectedAmount = null;
                    });
                  },
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
                DonationButton(
                  parms: AddCartItemParms(
                    programId: widget.detailsModel.id.toString(),
                    id: widget.detailsModel.items?.first.id.toString() ?? '0',
                    donation: widget.detailsModel.items?.first.donationTypeGuid ?? '',
                    recurrence: selectedCurrency ?? '',
                    type: '2',
                    quantity: 1,
                    campaign: widget.detailsModel.items?.first.campaignGuid,
                    amount: int.tryParse(amountController.text) ?? -1,
                  ),
                ),
              ].paddingDirectional(bottom: 12),
            ),
          ),
        ],
      ),
    );
  }
}
