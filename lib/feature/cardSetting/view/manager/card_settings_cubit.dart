import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tua/core/network/local/hive_data_base.dart';
import 'package:tua/feature/cardSetting/data/data_source/card_settings_data_source.dart';
import 'package:tua/feature/cardSetting/data/models/save_card_response.dart';

import '../../../cart/data/data_source/hyper_pay_data_source.dart';
import '../../../cart/data/models/hyper_pay_config_response.dart';
import '../../data/models/get_cards_response.dart';

part 'card_settings_state.dart';

class CardSettingsCubit extends Cubit<CardSettingsState> {
  CardSettingsCubit(this._cardSettingsDataSource, this._hyperPayDataSource)
      : super(CardSettingsInitial());

  final CardSettingsDataSource _cardSettingsDataSource;
  final HyperPayDataSource _hyperPayDataSource;

  HyperPayConfigData? _config;
  HyperPayConfigData? get config => _config;

  List<CardInfo>? _cachedCards;
  List<CardInfo>? get cachedCards => _cachedCards;

  final _cacheKey = "cards_cache";

  /// Save Card
  Future<void> saveCard() async {
    emit(SaveCardLoading());
    final response = await _cardSettingsDataSource.saveCard();
    response.fold(
          (failure) => emit(SaveCardError(failure.errMessage)),
          (success) => emit(SaveCardSuccess(success)),
    );
  }

  /// Get HyperPay Config
  Future<void> getHyperPayConfig({String? lang}) async {
    emit(HyperPayConfigLoading());
    final result = await _hyperPayDataSource.getHyperPayConfig(lang: lang);
    result.fold(
          (failure) {
        emit(HyperPayConfigError(failure.errMessage));
      },
          (configData) {
        _config = configData;
        emit(HyperPayConfigLoaded(configData));
      },
    );
  }

  /// Get Cards with Cache
  Future<void> getCards() async {
    // Load from cache first
    await _loadCachedCards();

    // Then fetch from API
    await _fetchCardsFromApi();
  }

  /// Load Cached Cards
  Future<void> _loadCachedCards() async {
    emit(GetCardsLoading());

    try {
      final box = await openHiveBox("cardsBox");
      final cachedJson = box.get(_cacheKey);

      if (cachedJson != null && cachedJson.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(cachedJson);
        final cards = jsonList.map((e) => CardInfo.fromJson(e)).toList();
        _cachedCards = cards;

        emit(GetCardsSuccess(cards, fromCache: true));
      } else {
        emit(GetCardsLoading());
      }
    } catch (e) {
      log("Cache load error: $e");
      emit(GetCardsLoading());
    }
  }

  /// Fetch Cards from API
  Future<void> _fetchCardsFromApi() async {
    emit(GetCardsLoading());

    final response = await _cardSettingsDataSource.getCards();

    response.fold(
          (failure) {
        // If we have cached data, don't emit error
        if (_cachedCards == null) {
          emit(GetCardsError(failure.errMessage));
        }
      },
          (cards) async {
        _cachedCards = cards;

        // Save to cache
        await _saveToCache(cards);

        emit(GetCardsSuccess(cards, fromCache: false));
      },
    );
  }

  /// Save to Hive Cache
  Future<void> _saveToCache(List<CardInfo> cards) async {
    try {
      final box = await openHiveBox("cardsBox");
      final jsonList = cards.map((card) => card.toJson()).toList();
      final jsonStr = jsonEncode(jsonList);
      await box.put(_cacheKey, jsonStr);
    } catch (e) {
      log("Cache save error: $e");
    }
  }

  /// Clear Cache
  Future<void> clearCache() async {
    try {
      final box = await openHiveBox("cardsBox");
      await box.delete(_cacheKey);
      _cachedCards = null;
    } catch (_) {}
  }

  /// Refresh Cards
  Future<void> refresh() async {
    await getCards();
  }

  /// Delete Card and Refresh
  Future<void> deleteCard(String cardId) async {
    emit(DeleteCardLoading());

    // Call your delete API here
    // final response = await _cardSettingsDataSource.deleteCard(cardId);

    // After successful deletion, refresh the list
    await refresh();
  }
}