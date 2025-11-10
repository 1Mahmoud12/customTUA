import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_switch_button.dart';

import '../../../../donations/data/models/donation_program_details_model.dart';

class CurrencyWidget extends StatelessWidget {
  final DonationProgramDetailsModel details;
  final Function(String key)? onChange; // optional callback

  const CurrencyWidget({super.key, required this.details, this.onChange});

  @override
  Widget build(BuildContext context) {
    final recurringTypes = details.recurringTypes ?? {};

    // Convert map to list of SwitchButtonModel
    final switchItems =
        recurringTypes.entries.map((entry) {
          return SwitchButtonModel(title: entry.value, id: entry.key.hashCode);
        }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'set_currency_frequency'.tr(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        if (switchItems.isNotEmpty)
          CustomSwitchButton(
            items: switchItems,

            onChange: (selectedId) {
              // Find selected index by ID
              final index = switchItems.indexWhere((e) => e.id == selectedId);

              if (index != -1) {
                final selectedValue = recurringTypes.values.elementAt(index);
                onChange?.call(selectedValue);
              }
            },
            initialIndex: 0,
          )
        else
          Text('no_recurring_types_available'.tr(), style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
