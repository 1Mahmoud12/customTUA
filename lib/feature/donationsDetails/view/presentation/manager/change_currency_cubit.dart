import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../donations/data/models/donation_program_details_model.dart';

part 'change_currency_state.dart';

class ChangeCurrencyCubit extends Cubit<ChangeCurrencyState> {
  ChangeCurrencyCubit(this.details) : super(ChangeCurrencyInitial()) {
    _init();
  }

  final DonationProgramDetailsModel details;

  int selectedCurrencyIndex = 0; // 0 = JOD, 1 = USD
  Map<int, int> itemCounts = {}; // itemId -> count

  void _init() {
    // init all counts = 0
    for (final item in details.items ?? []) {
      itemCounts[item.id] = 0;
    }

    emit(DonationLoaded(items: details.items ?? [], currency: selectedCurrency, counts: itemCounts, total: _calculateTotal()));
  }

  String get selectedCurrency => selectedCurrencyIndex == 0 ? 'JOD' : 'USD';

  void changeCurrency(int index) {
    selectedCurrencyIndex = index;
    emit(DonationLoaded(items: details.items ?? [], currency: selectedCurrency, counts: itemCounts, total: _calculateTotal()));
  }

  void increase(int itemId) {
    itemCounts[itemId] = (itemCounts[itemId] ?? 0) + 1;
    emit(DonationLoaded(items: details.items ?? [], currency: selectedCurrency, counts: itemCounts, total: _calculateTotal()));
  }

  void decrease(int itemId) {
    if ((itemCounts[itemId] ?? 0) > 0) {
      itemCounts[itemId] = itemCounts[itemId]! - 1;
    }
    emit(DonationLoaded(items: details.items ?? [], currency: selectedCurrency, counts: itemCounts, total: _calculateTotal()));
  }
  void resetItemCounts() {
    itemCounts.updateAll((key, value) => 0);

    emit(DonationLoaded(
      items: details.items ?? [],
      currency: selectedCurrency,
      counts: itemCounts,
      total: _calculateTotal(),
    ));
  }

  double _calculateTotal() {
    double total = 0;

    for (final item in details.items ?? []) {
      final int count = itemCounts[item.id] ?? 0;

      if (selectedCurrency == 'JOD') {
        total += count * (item.amountJod ?? 0);
      } else {
        total += count * (item.amountUsd ?? 0);
      }
    }

    return total;
  }
}
