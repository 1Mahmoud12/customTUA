import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_switch_button.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('set_currency_frequency'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        CustomSwitchButton(
          items: [SwitchButtonModel(title: 'once', id: 3), SwitchButtonModel(title: 'monthly', id: 1), SwitchButtonModel(title: 'yearly', id: 2)],
          onChange: (p0) {},
          initialIndex: 0,
        ),
      ],
    );
  }
}
