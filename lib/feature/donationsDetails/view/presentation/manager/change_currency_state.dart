part of 'change_currency_cubit.dart';

@immutable
sealed class ChangeCurrencyState {}

class ChangeCurrencyInitial extends ChangeCurrencyState {}

class DonationLoaded extends ChangeCurrencyState {
  final List<DonationItemModel> items;
  final String currency;
  final Map<int, int> counts;
  final double total;

  DonationLoaded({
    required this.items,
    required this.currency,
    required this.counts,
    required this.total,
  });
}