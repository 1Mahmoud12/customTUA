import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/feature/zakatCalculator/view/presentation/widgets/add_amount_button.dart';
import 'package:tua/feature/zakatCalculator/view/presentation/widgets/cash_amount_text_form_field.dart';
import 'package:tua/feature/zakatCalculator/view/presentation/widgets/total_zakat_amount_widget.dart';

import '../../../../../core/component/buttons/custom_text_button.dart';
import '../manager/zakat_calculator__cubit.dart';
import '../manager/zakat_calculator__state.dart';

class CashCalculateWidget extends StatelessWidget {
  const CashCalculateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ZakatCalculatorCubit(),
      child: BlocBuilder<ZakatCalculatorCubit, ZakatCalculatorState>(
        builder: (context, state) {
          final cubit = context.read<ZakatCalculatorCubit>();

          return Column(
            children: [
              // Dynamic list of amount fields
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit.amountControllers.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return CashAmountTextFormField(
                    index: index,
                    controller: cubit.amountControllers[index],
                    currency: cubit.currencies[index],
                    showRemoveButton: cubit.amountControllers.length > 1,
                  );
                },
              ),

              const SizedBox(height: 5),

              // Add amount button
              const AddAmountButton(),

              const SizedBox(height: 12),

              // Calculate button
              CustomTextButton(
                onPress: () {
                  cubit.calculateZakat();
                },
                childText: 'calculate',
              ),

              const SizedBox(height: 24),

              // Show result only after calculation
              if (state is ZakatCalculatorBelowNisab)
                TotalZakatAmountWidget(
                  isBelowNisab: true,
                  nisab: state.nisab,
                )
              else if (state is ZakatCalculatorSuccess)
                TotalZakatAmountWidget(
                  isBelowNisab: false,
                  zakatAmount: state.zakatAmount,
                ),
            ],
          );
        },
      ),
    );
  }
}