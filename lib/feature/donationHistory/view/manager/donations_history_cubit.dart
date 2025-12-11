import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/network/local/hive_data_base.dart';

import '../../data/data_source/get_donations_history_data_source.dart';
import '../../data/models/donation_history_filter_params.dart';
import '../../data/models/donations_history_response.dart';
import 'donations_history_state.dart';

class DonationsHistoryCubit extends Cubit<DonationsHistoryState> {
  final DonationsHistoryDataSource _dataSource;

  DonationsHistoryCubit(this._dataSource) : super(DonationsHistoryInitial());

  DonationsHistoryResponse? _cachedResponse;

  DonationsHistoryResponse? get cached => _cachedResponse;

  final _cacheKey = "donations_history_cache";
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  void onStartDateSelected(DateTime date) {
    startDate = date;
    startDateController.text = DateFormat('dd-MM-yyyy').format(date);
    emit(DonationsHistoryInitial());
  }

  void onEndDateSelected(DateTime date) {
    if (startDate == null) {
      emit(DonationsHistoryError('please_select_start_date_first'));
      return;
    }
    if (startDate != null && date.isBefore(startDate!)) {
      emit(DonationsHistoryError('end_date_cannot_be_before_start_date'));
      return;
    }

    endDate = date;
    endDateController.text = DateFormat('dd-MM-yyyy').format(date);
    emit(DonationsHistoryInitial());
  }

  /// Load with optional filters
  Future<void> loadHistory() async {
    await _loadCachedData();

    await _fetchDataFromApi();
  }

  /// Load cached history
  Future<void> _loadCachedData() async {
    emit(DonationsHistoryLoading());

    try {
      final box = await openHiveBox("donationsBox");

      final cachedJson = box.get(_cacheKey);

      if (cachedJson != null && cachedJson.isNotEmpty) {
        final model = DonationsHistoryResponse.fromJson(jsonDecode(cachedJson));
        _cachedResponse = model;

        emit(DonationsHistoryLoaded(response: model, fromCache: true));
      } else {
        emit(DonationsHistoryLoading());
      }
    } catch (e) {
      emit(DonationsHistoryLoading());
    }
  }

  /// Fetch fresh history from API
  Future<void> _fetchDataFromApi() async {
    final parms = DonationHistoryFilterParams(
      startDate: startDateController.text.trim(),
      endDate: endDateController.text.trim(),
    );

    final result = await _dataSource.getDonationsHistory(params: parms);

    result.fold(
      (failure) {
        if (_cachedResponse == null) {
          emit(DonationsHistoryError(failure.errMessage));
        }
      },
      (response) async {
        _cachedResponse = response;

        await _saveToCache(response);

        emit(DonationsHistoryLoaded(response: response, fromCache: false));
      },
    );
  }

  /// Save to Hive cache
  Future<void> _saveToCache(DonationsHistoryResponse model) async {
    try {
      final box = await openHiveBox("donationsBox");

      final jsonStr = jsonEncode(model.toJson());
      await box.put(_cacheKey, jsonStr);
    } catch (e) {
      log("cache save error: $e");
    }
  }

  /// Clear cache
  Future<void> clearCache() async {
    try {
      final box = await openHiveBox("donationsBox");
      await box.delete(_cacheKey);
      _cachedResponse = null;
    } catch (_) {}
  }

  /// Force refresh
  Future<void> refresh() async {
    await loadHistory();
  }

  @override
  Future<void> close() {
    startDateController.dispose();
    endDateController.dispose();
    return super.close();
  }
}
