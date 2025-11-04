import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';

class QuickCalculateWidget extends StatelessWidget {
  const QuickCalculateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: TextEditingController(),
      hintText: '100',
      nameField: 'amount_value',
      textInputType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      suffixIcon: Padding(padding: const EdgeInsets.all(16), child: Text('jod'.tr(), style: Theme.of(context).textTheme.displayMedium)),
    );
  }
}
