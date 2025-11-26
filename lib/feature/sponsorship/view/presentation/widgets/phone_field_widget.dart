import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/app_images.dart';

class PhoneFieldWidget extends StatefulWidget {
  final Function(String)? onChange;
  final String? nameField;
  final String? hintText;
  final String? initialValue;

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
  // Jordan only configuration
  static const String countryCode = '+962';
  static const int phoneLength = 9;
  static const String countryImage = AppImages.jo;

  late TextEditingController phoneController;
  bool _mounted = true;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(
      text: _extractPhoneWithoutCode(widget.initialValue),
    );

    // Sync initial value
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_mounted) {
        widget.onChange?.call('$countryCode${phoneController.text}');
      }
    });
  }

  @override
  void dispose() {
    _mounted = false;
    phoneController.dispose();
    super.dispose();
  }

  String? _extractPhoneWithoutCode(String? fullNumber) {
    if (fullNumber == null || fullNumber.isEmpty) return '';
    if (fullNumber.startsWith(countryCode)) {
      return fullNumber.substring(countryCode.length);
    }
    return fullNumber;
  }

  /// Validates Jordan phone numbers
  /// Valid formats: 7XXXXXXXX (starts with 7, 9 digits total)
  String? _validateJordanPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'please_enter_phone_number'.tr();
    }

    // Remove any spaces or special characters
    final cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');

    // Check length
    if (cleanPhone.length != phoneLength) {
      return 'phone_must_be_9_digits'.tr();
    }

    // Jordan mobile numbers start with 7
    if (!cleanPhone.startsWith('7')) {
      return 'jordan_phone_must_start_with_7'.tr();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 7),
      outPadding: EdgeInsets.zero,
      controller: phoneController,
      hintText: widget.hintText ?? '7X XXX XXXX',
      nameField: widget.nameField,
      textInputType: TextInputType.phone,
      autoValidateMode: AutovalidateMode.disabled, // ✅ Validation only on submit
      validator: _validateJordanPhone,
      onChange: (value) {
        // Enforce max length
        if (value.length > phoneLength) {
          phoneController.text = value.substring(0, phoneLength);
          phoneController.selection = TextSelection.fromPosition(
            TextPosition(offset: phoneController.text.length),
          );
        }
        widget.onChange?.call('$countryCode${phoneController.text}');
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(phoneLength),
        FilteringTextInputFormatter.digitsOnly,
      ],
      prefixIcon: Padding(
        padding: EdgeInsets.only(
          left: context.locale.languageCode == 'ar' ? 0 : 16,
          right: context.locale.languageCode == 'ar' ? 16 : 0,
        ),
        child: Container(
          width: 90,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                countryImage,
                width: 32,
                height: 24,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),
              const Text(
                countryCode,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}