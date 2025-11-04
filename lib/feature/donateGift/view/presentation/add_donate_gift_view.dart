import 'package:flutter/material.dart';
import 'package:tua/core/component/cache_image.dart';
import 'package:tua/core/component/drop_menu.dart' show CustomPopupMenu;
import 'package:tua/core/component/sharred_divider.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_images.dart';
import 'package:tua/core/utils/constant_gaping.dart';

import '../../../../core/component/buttons/custom_text_button.dart';
import '../../../../core/component/custom_app_bar.dart';
import '../../../../core/component/custom_check_box.dart';
import '../../../../core/component/custom_drop_down_menu.dart';
import '../../../../core/component/fields/custom_text_form_field.dart';
import 'widget/gift_occasion_card.dart';

class CountryPhoneData {
  final String code;
  final String image;
  final int length;

  CountryPhoneData({required this.code, required this.length, required this.image});
}

class AddDonateGiftView extends StatefulWidget {
  const AddDonateGiftView({super.key});

  @override
  State<AddDonateGiftView> createState() => _AddDonateGiftViewState();
}

class _AddDonateGiftViewState extends State<AddDonateGiftView> {
  final senderNameController = TextEditingController();
  final senderEmailController = TextEditingController();
  final amountController = TextEditingController();
  final recipientNameController = TextEditingController();
  final recipientEmailController = TextEditingController();
  final senderMobileController = TextEditingController();
  final recipientMobileController = TextEditingController();
  final messageController = TextEditingController();

  String? selectedDonor;
  String? selectedCurrency = 'JOD';
  bool allowRecipientToSeeAmount = false;

  // Map for country codes and phone number length
  final Map<int, CountryPhoneData> countryPhoneData = {
    1: CountryPhoneData(code: '+20', length: 10, image: AppImages.eg), // Egypt (without leading zero)
    2: CountryPhoneData(code: '+962', length: 9, image: AppImages.jo), // Jordan
    // Add more countries as needed
  };

  String selectedCountryCode = '+20'; // Default country code
  int phoneMaxLength = 10; // Default phone length
  int currentCountryId = 1; // Default to Egypt
  List<String> countries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Donate your Gift', centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GiftOccasionCard(
                title: 'Marriage',
                description:
                    'Share the joy and love of marriage and help the newlyweds give back to their community. Your wedding gift will help provide food for families in need.',
                imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpHZqIQHuc3I-R1eB_fyiUnb0yg9aub7KzB9SgWJk2wMBww2Vv',
              ),
              h15,
              CustomPopupMenu(
                borderRadius: 40,
                buttonPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                items: [DropDownModel(name: 'Donor name 1', value: 1), DropDownModel(name: 'Donor name 2', value: 2)],
                nameField: 'Select donor name*',
                onChanged: (val) {
                  setState(() {
                    selectedDonor = val?.name;
                  });
                },
                selectedItem: DropDownModel(name: 'select', value: -1),
              ),
              h10,
              CustomTextFormField(
                nameField: 'Specify the amount*',
                controller: amountController,
                hintText: '100',
                outPadding: EdgeInsets.zero,
                textInputType: TextInputType.phone,
                inputFormatters: [],
                onChange: (value) {},
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: 80,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomPopupMenu(
                            fillColor: AppColors.transparent,
                            borderColor: AppColors.transparent,
                            selectedItem: DropDownModel(name: selectedCurrency ?? 'JOD', value: -1),
                            items: [DropDownModel(name: 'JOD', value: 1), DropDownModel(name: 'SAR', value: 2), DropDownModel(name: 'EGP', value: 3)],
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              h15,
              CustomTextFormField(nameField: "Sender's name*", controller: senderNameController, hintText: 'optional', outPadding: EdgeInsets.zero),
              h10,
              CustomTextFormField(
                nameField: "Sender's Email*",
                controller: senderEmailController,
                hintText: 'info@gmail.com',
                outPadding: EdgeInsets.zero,
              ),
              h10,
              CustomTextFormField(
                controller: recipientNameController,
                nameField: "Recipient's name*",
                hintText: 'optional',
                outPadding: EdgeInsets.zero,
              ),
              h10,
              CustomTextFormField(
                controller: recipientEmailController,
                nameField: "Recipient's Email*",
                hintText: 'info@gmail.com',
                outPadding: EdgeInsets.zero,
              ),
              h10,
              CustomTextFormField(
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 7),
                outPadding: EdgeInsets.zero,
                controller: senderMobileController,
                hintText: '7XX XXX XXX',
                nameField: "Sender's Mobile number*",
                textInputType: TextInputType.phone,
                onChange: (value) {},
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 110,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                          child: const CacheImage(
                            urlImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSXV5t4bvmYPHZwFzjNeI82O7EIttGRiMYxQ&s',
                          ),
                        ),
                        Expanded(
                          child: CustomPopupMenu(
                            fillColor: AppColors.transparent,
                            borderColor: AppColors.transparent,
                            selectedItem: DropDownModel(name: '+962', value: -1),
                            items: [
                              DropDownModel(name: '+962', value: 1),
                              DropDownModel(name: '+966', value: 2),
                              DropDownModel(name: '+971', value: 3),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                final int countryId = value.value;
                                if (countryPhoneData.containsKey(countryId)) {
                                  setState(() {
                                    selectedCountryCode = countryPhoneData[countryId]!.code;
                                    phoneMaxLength = countryPhoneData[countryId]!.length;
                                    currentCountryId = countryId;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        // const SizedBox(width: 4),
                        // Container(
                        //   height: 20,
                        //   width: 1,
                        //   color: AppColors.secondDividerColor,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              h10,
              CustomTextFormField(
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 7),
                outPadding: EdgeInsets.zero,
                controller: recipientMobileController,
                hintText: '7XX XXX XXX',
                nameField: "Recipient's Mobile number*",
                textInputType: TextInputType.phone,
                onChange: (value) {},
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 110,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                          child: const CacheImage(
                            urlImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSXV5t4bvmYPHZwFzjNeI82O7EIttGRiMYxQ&s',
                          ),
                        ),
                        Expanded(
                          child: CustomDropDownMenu(
                            fillColor: AppColors.transparent,
                            borderColor: AppColors.transparent,
                            selectedItem: DropDownModel(name: '+962', value: -1),
                            items: [
                              DropDownModel(name: '+962', value: 1),
                              DropDownModel(name: '+966', value: 2),
                              DropDownModel(name: '+971', value: 3),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                final int countryId = value.value;
                                if (countryPhoneData.containsKey(countryId)) {
                                  setState(() {
                                    selectedCountryCode = countryPhoneData[countryId]!.code;
                                    phoneMaxLength = countryPhoneData[countryId]!.length;
                                    currentCountryId = countryId;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        // w5,
                        // Container(
                        //   height: 20,
                        //   width: 1,
                        //   color: AppColors.secondDividerColor,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              const SharredDivider(),

              CustomTextFormField(borderRadius: 8, controller: messageController, nameField: 'Message*', hintText: 'type your message', maxLines: 5),

              h15,
              Row(
                children: [
                  CustomCheckBox(
                    checkBox: allowRecipientToSeeAmount,
                    borderColor: AppColors.cNameStatusColor,
                    fillTrueValue: AppColors.cRadioColor,
                    onTap: (value) => setState(() => allowRecipientToSeeAmount = !allowRecipientToSeeAmount),
                  ),
                  w10,
                  Expanded(
                    child: Text(
                      'If you want to allow the recipient to see the amount, please check',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.cRadioColor),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              h20,
              CustomTextButton(onPress: () {}, childText: 'Pay now'),
            ],
          ),
        ),
      ),
    );
  }
}
