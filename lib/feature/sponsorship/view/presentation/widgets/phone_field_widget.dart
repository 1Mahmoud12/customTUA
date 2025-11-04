import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tua/core/component/custom_drop_down_menu.dart';
import 'package:tua/core/component/drop_menu.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_images.dart';

class PhoneFieldWidget extends StatefulWidget {
  final Function(String)? onChange;
  final String? nameField;
  final String? hintText;
  final String? initialValue; // ✅ Added to support prefilled phone

  const PhoneFieldWidget({
    super.key,
    this.onChange,
    this.nameField,
    this.hintText,
    this.initialValue,
  });

  @override
  State<PhoneFieldWidget> createState() => _PhoneFieldWidgetState();
}

class _PhoneFieldWidgetState extends State<PhoneFieldWidget> {
  final Map<int, CountryPhoneData> countryPhoneData = {
    1: CountryPhoneData(code: '+20', length: 10, image: AppImages.eg), // Egypt
    2: CountryPhoneData(code: '+962', length: 9, image: AppImages.jo), // Jordan
  };

  String selectedCountryCode = '+20';
  int phoneMaxLength = 10;
  int currentCountryId = 1;

  late TextEditingController senderMobileController;

  @override
  void initState() {
    super.initState();

    // ✅ Initialize controller with provided initial value
    senderMobileController = TextEditingController(
      text: _extractPhoneWithoutCode(widget.initialValue),
    );

    // ✅ Detect and set initial country based on prefix
    _detectCountryFromInitialValue(widget.initialValue);

    // Call initial onChange once to sync cubit value
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChange?.call('$selectedCountryCode${senderMobileController.text}');
    });
  }

  String? _extractPhoneWithoutCode(String? fullNumber) {
    if (fullNumber == null || fullNumber.isEmpty) return '';
    for (final entry in countryPhoneData.values) {
      if (fullNumber.startsWith(entry.code)) {
        return fullNumber.substring(entry.code.length);
      }
    }
    return fullNumber;
  }

  void _detectCountryFromInitialValue(String? fullNumber) {
    if (fullNumber == null) return;
    for (final entry in countryPhoneData.entries) {
      if (fullNumber.startsWith(entry.value.code)) {
        selectedCountryCode = entry.value.code;
        phoneMaxLength = entry.value.length;
        currentCountryId = entry.key;
        break;
      }
    }
  }

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
          senderMobileController.selection = TextSelection.fromPosition(
            TextPosition(offset: senderMobileController.text.length),
          );
        }
        widget.onChange?.call('$selectedCountryCode${senderMobileController.text}');
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(phoneMaxLength),
        FilteringTextInputFormatter.digitsOnly,
      ],
      prefixIcon: Padding(
        padding: EdgeInsets.only(
          left: context.locale.languageCode == 'ar' ? 0 : 16,
          right: context.locale.languageCode == 'ar' ? 16 : 0,
        ),
        child: SizedBox(
          width: 100,
          child: CustomPopupMenu(
            fillColor: AppColors.transparent,
            borderColor: AppColors.transparent,
            buttonPadding: const EdgeInsets.symmetric(horizontal: 4),
            menuItemPadding: EdgeInsets.zero,
            maxWidth: false,
            selectedItem: DropDownModel(
              name: selectedCountryCode,
              value: currentCountryId,
              showImage: true,
              image: countryPhoneData[currentCountryId]!.image,
            ),
            addSpacer: false,
            items: countryPhoneData.entries.map((entry) {
              final int countryId = entry.key;
              final CountryPhoneData data = entry.value;
              return DropDownModel(
                name: data.code,
                value: countryId,
                image: data.image,
                showImage: true,
              );
            }).toList(),
            onChanged: (value) {
              if (value != null && countryPhoneData.containsKey(value.value)) {
                final int countryId = value.value;
                setState(() {
                  selectedCountryCode = countryPhoneData[countryId]!.code;
                  phoneMaxLength = countryPhoneData[countryId]!.length;
                  currentCountryId = countryId;
                  senderMobileController.clear();
                });
                widget.onChange?.call('$selectedCountryCode${senderMobileController.text}');
              }
            },
          ),
        ),
      ),
    );
  }
}

class CountryPhoneData {
  final String code;
  final int length;
  final String image;

  CountryPhoneData({
    required this.code,
    required this.length,
    required this.image,
  });
}
