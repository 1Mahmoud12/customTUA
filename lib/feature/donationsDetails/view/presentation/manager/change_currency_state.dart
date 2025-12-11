part of 'change_currency_cubit.dart';

@immutable
sealed class ChangeCurrencyState {}

final class ChangeCurrencyInitial extends ChangeCurrencyState {}

final class DonationLoaded extends ChangeCurrencyState {
  final List<DonationItemModel> items;
  final List<DonationParentGroup> parents;
  final int selectedParentIndex;
  final String currency;
  final Map<int, int> counts;
  final double total;

  DonationLoaded({
    required this.items,
    required this.parents,
    required this.selectedParentIndex,
    required this.currency,
    required this.counts,
    required this.total,
  });
}