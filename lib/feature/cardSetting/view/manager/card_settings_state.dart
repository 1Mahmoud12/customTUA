part of 'card_settings_cubit.dart';

@immutable
sealed class CardSettingsState {}

final class CardSettingsInitial extends CardSettingsState {}

// ==================== Save Card States ====================
final class SaveCardLoading extends CardSettingsState {}

final class SaveCardSuccess extends CardSettingsState {
  final SaveCardResponse data;
  SaveCardSuccess(this.data);
}

final class SaveCardError extends CardSettingsState {
  final String message;
  SaveCardError(this.message);
}

// ==================== Get Cards States ====================
final class GetCardsLoading extends CardSettingsState {}

final class GetCardsSuccess extends CardSettingsState {
  final List<CardInfo> data;
  final bool fromCache;

  GetCardsSuccess(this.data, {this.fromCache = false});
}

final class GetCardsError extends CardSettingsState {
  final String message;
  GetCardsError(this.message);
}

// ==================== Delete Card States ====================
final class DeleteCardLoading extends CardSettingsState {}

final class DeleteCardSuccess extends CardSettingsState {}

final class DeleteCardError extends CardSettingsState {
  final String message;
  DeleteCardError(this.message);
}

// ==================== HyperPay Config States ====================
final class HyperPayConfigLoading extends CardSettingsState {}

final class HyperPayConfigLoaded extends CardSettingsState {
  final HyperPayConfigData data;
  HyperPayConfigLoaded(this.data);
}

final class HyperPayConfigError extends CardSettingsState {
  final String message;
  HyperPayConfigError(this.message);
}