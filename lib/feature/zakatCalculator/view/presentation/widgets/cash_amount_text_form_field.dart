import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/fields/custom_text_form_field.dart';

import '../../../../../core/themes/colors.dart';
import '../manager/zakat_calculator__cubit.dart';

class CashAmountTextFormField extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final String currency;
  final bool showRemoveButton;

  const CashAmountTextFormField({
    super.key,
    required this.index,
    required this.controller,
    required this.currency,
    this.showRemoveButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ZakatCalculatorCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: controller,
            hintText: 'enter_amount',
            nameField: 'amount_value',
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: PopupMenuButton<String>(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        currency,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.cP50,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_drop_down, color: AppColors.cP50, size: 20),
                    ],
                  ),
                ),
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(value: 'JOD', child: Text('JOD')),
                  const PopupMenuItem(value: 'USD', child: Text('USD')),
                ],
                onSelected: (String value) {
                  cubit.changeCurrency(index, value);
                },
              ),
            ),
          ),
        ),
        if (showRemoveButton) ...[
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              cubit.removeAmountField(index);
            },
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
          ),
        ],
      ],
    );
  }
}