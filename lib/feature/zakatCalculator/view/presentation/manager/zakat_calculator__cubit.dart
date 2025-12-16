import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants_models.dart';
import 'zakat_calculator__state.dart';

class ZakatCalculatorCubit extends Cubit<ZakatCalculatorState> {
  ZakatCalculatorCubit() : super(ZakatCalculatorInitial());

  // Constants from API
  static double nisab = ConstantsModels.lookupModel?.data?.zakatCalculation?.nisab ?? 5822.5;
  static double zakatPercentage =
      ConstantsModels.lookupModel?.data?.zakatCalculation?.zakatPercentage ?? 2.577;
  static double usdToJod = ConstantsModels.lookupModel?.data?.zakatCalculation?.usdToJod ?? 0.71;

  // List to hold all amount controllers
  List<TextEditingController> amountControllers = [TextEditingController()];

  // Current selected currency for each field
  List<String> currencies = ['JOD'];

  // Has calculated flag
  bool hasCalculated = false;

  void addAmountField() {
    amountControllers.add(TextEditingController());
    currencies.add('JOD');
    emit(
      ZakatCalculatorFieldsUpdated(
        controllers: List.from(amountControllers),
        currencies: List.from(currencies),
      ),
    );
  }

  void removeAmountField(int index) {
    if (amountControllers.length > 1) {
      amountControllers[index].dispose();
      amountControllers.removeAt(index);
      currencies.removeAt(index);
      emit(
        ZakatCalculatorFieldsUpdated(
          controllers: List.from(amountControllers),
          currencies: List.from(currencies),
        ),
      );
    }
  }

  void changeCurrency(int index, String newCurrency) {
    currencies[index] = newCurrency;
    emit(
      ZakatCalculatorFieldsUpdated(
        controllers: List.from(amountControllers),
        currencies: List.from(currencies),
      ),
    );
  }

  void calculateZakat() {
    double totalAmountInJOD = 0;

    // Calculate total amount in JOD
    for (int i = 0; i < amountControllers.length; i++) {
      final text = amountControllers[i].text.trim();
      if (text.isEmpty) continue;

      final amount = double.tryParse(text) ?? 0;

      // Convert to JOD if currency is USD
      if (currencies[i] == 'USD') {
        totalAmountInJOD += amount * usdToJod;
      } else {
        totalAmountInJOD += amount;
      }
    }

    hasCalculated = true;

    // Check if amount is less than nisab
    if (totalAmountInJOD < nisab) {
      emit(ZakatCalculatorBelowNisab(totalAmount: totalAmountInJOD, nisab: nisab));
    } else {
      // Calculate zakat amount
      final zakatAmount = totalAmountInJOD * (zakatPercentage / 100);
      emit(ZakatCalculatorSuccess(totalAmount: totalAmountInJOD, zakatAmount: zakatAmount));
    }
  }

  void reset() {
    // Dispose all controllers except the first one
    for (int i = 1; i < amountControllers.length; i++) {
      amountControllers[i].dispose();
    }

    // Clear the first controller
    amountControllers.first.clear();

    // Reset to single field
    amountControllers = [amountControllers.first];
    currencies = ['JOD'];
    hasCalculated = false;

    emit(ZakatCalculatorInitial());
  }

  @override
  Future<void> close() {
    // Dispose all controllers
    for (var controller in amountControllers) {
      controller.dispose();
    }
    return super.close();
  }
}
