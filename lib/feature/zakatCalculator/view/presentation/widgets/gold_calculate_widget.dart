import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';
import 'package:tua/core/utils/constants_models.dart';

class GoldCalculateWidget extends StatelessWidget {
  const GoldCalculateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: TextEditingController(),
          hintText: 'amount_value',
          nameField: 'my_financial_accounts',
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          suffixIcon: Padding(padding: const EdgeInsets.all(16), child: Text(ConstantsModels.currency.tr(), style: Theme.of(context).textTheme.displayMedium)),
        ),
        const SizedBox(height: 24),
        CustomTextFormField(
          controller: TextEditingController(),
          hintText: 'value_of_the_bank_account',
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          suffixIcon: Padding(padding: const EdgeInsets.all(16), child: Text(ConstantsModels.currency.tr(), style: Theme.of(context).textTheme.displayMedium)),
        ),
        const SizedBox(height: 24),
        CustomTextFormField(
          controller: TextEditingController(),
          hintText: 'value_of_monetary_amount',
          nameField: 'creditor',
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          suffixIcon: Padding(padding: const EdgeInsets.all(16), child: Text(ConstantsModels.currency.tr(), style: Theme.of(context).textTheme.displayMedium)),
        ),
        const SizedBox(height: 24),
        CustomTextFormField(
          controller: TextEditingController(),
          hintText: 'house_rent_value',
          nameField: 'debtor',
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          suffixIcon: Padding(padding: const EdgeInsets.all(16), child: Text(ConstantsModels.currency.tr(), style: Theme.of(context).textTheme.displayMedium)),
        ),
        const SizedBox(height: 24),
        CustomTextFormField(
          controller: TextEditingController(),
          hintText: 'instalment_value',
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          suffixIcon: Padding(padding: const EdgeInsets.all(16), child: Text(ConstantsModels.currency.tr(), style: Theme.of(context).textTheme.displayMedium)),
        ),
        const SizedBox(height: 24),
        CustomTextFormField(
          controller: TextEditingController(),
          hintText: 'value_of_the_car_installment',
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          suffixIcon: Padding(padding: const EdgeInsets.all(16), child: Text(ConstantsModels.currency.tr(), style: Theme.of(context).textTheme.displayMedium)),
        ),
      ],
    );
  }
}
