import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/drop_menu.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_images.dart';
import 'package:tua/feature/donateGift/view/presentation/add_donate_gift_view.dart';

class PhoneFieldWidget extends StatefulWidget {
  final Function(String)? onChange;
  final String? nameField;
  final String? hintText;

  const PhoneFieldWidget({super.key, this.onChange, this.nameField, this.hintText});

  @override
  State<PhoneFieldWidget> createState() => _PhoneFieldWidgetState();
}

class _PhoneFieldWidgetState extends State<PhoneFieldWidget> {
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
  final senderMobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 7),
      outPadding: EdgeInsets.zero,
      controller: senderMobileController,
      hintText: widget.hintText ?? 'XX XXX XXX',
      nameField: widget.nameField,
      textInputType: TextInputType.phone,
      onChange: (value) {
        if (value.length > phoneMaxLength) {
          senderMobileController.text = value.substring(0, phoneMaxLength);
          senderMobileController.selection = TextSelection.fromPosition(TextPosition(offset: senderMobileController.text.length));
        }
        widget.onChange?.call('$selectedCountryCode${senderMobileController.text}');
      },
      inputFormatters: [LengthLimitingTextInputFormatter(phoneMaxLength), FilteringTextInputFormatter.digitsOnly],
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: context.locale.languageCode == 'ar' ? 0 : 16, right: context.locale.languageCode == 'ar' ? 16 : 0),
        child: SizedBox(
          width: 100,
          child: CustomPopupMenu(
            fillColor: AppColors.transparent,
            borderColor: AppColors.transparent,
            buttonPadding: const EdgeInsets.symmetric(horizontal: 4),
            menuItemPadding: EdgeInsets.zero,
            maxWidth: false,
            selectedItem: DropDownModel(name: '+962', value: -1, showImage: true, image: AppImages.jo),
            addSpacer: false,
            items:
                countryPhoneData.entries.map((entry) {
                  final int countryId = entry.key;
                  final CountryPhoneData data = entry.value;
                  return DropDownModel(name: data.code, value: countryId, image: data.image, showImage: true);
                }).toList(),
            onChanged: (value) {
              if (value != null) {
                final int countryId = value.value;
                if (countryPhoneData.containsKey(countryId)) {
                  setState(() {
                    selectedCountryCode = countryPhoneData[countryId]!.code;
                    phoneMaxLength = countryPhoneData[countryId]!.length;
                    currentCountryId = countryId;
                    senderMobileController.clear();
                    widget.onChange?.call('$selectedCountryCode${senderMobileController.text}');
                  });
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
