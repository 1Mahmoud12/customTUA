import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/constants_models.dart';
import '../../../../donations/data/models/donation_program_details_model.dart';

part 'change_currency_state.dart';

class ChangeCurrencyCubit extends Cubit<ChangeCurrencyState> {
  ChangeCurrencyCubit(this.details) : super(ChangeCurrencyInitial()) {
    _init();
  }

  final DonationProgramDetailsModel details;

  int selectedCurrencyIndex = 0; // 0 = JOD, 1 = USD
  int selectedParentIndex = 0; // current parent tab
  Map<int, int> itemCounts = {}; // itemId -> count

  void _init() {
    // Get all parents
    final parents = details.items?.parents ?? [];

    // Initialize counts for all items from all parents
    for (final parent in parents) {
      for (final item in parent.items ?? []) {
        itemCounts[item.id] = 0;
      }
    }

    // Get items from first parent (if exists)
    final currentItems = parents.isNotEmpty
        ? (parents[0].items ?? [])
        : <DonationItemModel>[];

    emit(DonationLoaded(
      items: currentItems,
      parents: parents,
      selectedParentIndex: selectedParentIndex,
      currency: selectedCurrency,
      counts: itemCounts,
      total: _calculateTotal(),
    ));
  }

  String get selectedCurrency => ConstantsModels.currency;

  void changeCurrency(int index) {
    selectedCurrencyIndex = index;
    _emitLoadedState();
  }

  void changeParent(int index) {
    final parents = details.items?.parents ?? [];
    if (index >= 0 && index < parents.length) {
      // Reset all item counts to 0 when changing parent
      itemCounts.updateAll((key, value) => 0);

      selectedParentIndex = index;
      _emitLoadedState();
    }
  }
  void increase(int itemId) {
    itemCounts[itemId] = (itemCounts[itemId] ?? 0) + 1;
    _emitLoadedState();
  }

  void decrease(int itemId) {
    if ((itemCounts[itemId] ?? 0) > 0) {
      itemCounts[itemId] = itemCounts[itemId]! - 1;
    }
    _emitLoadedState();
  }

  void resetItemCounts() {
    itemCounts.updateAll((key, value) => 0);
    _emitLoadedState();
  }

  void _emitLoadedState() {
    final parents = details.items?.parents ?? [];
    final currentItems = parents.isNotEmpty && selectedParentIndex < parents.length
        ? (parents[selectedParentIndex].items ?? [])
        : <DonationItemModel>[];

    emit(DonationLoaded(
      items: currentItems,
      parents: parents,
      selectedParentIndex: selectedParentIndex,
      currency: selectedCurrency,
      counts: itemCounts,
      total: _calculateTotal(),
    ));
  }

  double _calculateTotal() {
    double total = 0;

    // Calculate total from ALL items (not just current parent)
    final parents = details.items?.parents ?? [];
    for (final parent in parents) {
      for (final item in parent.items ?? []) {
        final int count = itemCounts[item.id] ?? 0;

        if (selectedCurrency.toLowerCase() == 'jod') {
          total += count * (item.amountJod ?? 0);
        } else {
          total += count * (item.amountUsd ?? 0);
        }
      }
    }

    return total;
  }
}