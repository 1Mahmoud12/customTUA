import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/custom_switch_button.dart';

import '../../../../donations/data/models/donation_program_details_model.dart';

class CurrencyWidget extends StatelessWidget {
  final DonationProgramDetailsModel details;
  final Function(String key)? onChange;

  const CurrencyWidget({super.key, required this.details, this.onChange});

  @override
  Widget build(BuildContext context) {
    final recurringTypes = details.recurringTypes ?? {};

    // Convert map to list with index-based IDs
    final entriesList = recurringTypes.entries.toList();

    final switchItems =
        entriesList
            .asMap()
            .entries
            .map(
              (entry) => SwitchButtonModel(
                title: entry.value.value, // value of the Map<String,String>
                id: entry.key, // ID = index (0,1,2,…)
              ),
            )
            .toList();

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
            initialIndex: 0, // FIRST ITEM SELECTED BY DEFAULT
            onChange: (selectedIndex) {
              final selectedValue = entriesList[selectedIndex].value;
              onChange?.call(selectedValue);
            },
          )
        else
          Text('no_recurring_types_available'.tr(), style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
