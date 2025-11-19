import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/network/local/hive_data_base.dart';
import 'package:tua/feature/donations/data/models/donation_type_model.dart';

import '../../../donations/data/data_source/donation_types_data_source.dart';
import 'donation_types_state.dart';

class DonationTypesCubit extends Cubit<DonationTypesState> {
  final DonationTypesDataSource _dataSource;

  DonationTypesCubit(this._dataSource) : super(DonationTypesInitial());

  static const String _cacheKey = "donationTypesCache";
  List<DonationTypeModel> _cachedTypes = [];

  List<DonationTypeModel> get cachedTypes => _cachedTypes;

  /// Public Function
  Future<void> getDonationTypes() async {
    await _loadCachedTypes();
    await _fetchTypesFromApi();
  }

  /// Load Cached Types from Hive
  Future<void> _loadCachedTypes() async {
    final box = await openHiveBox("donationTypesBox");
    final cachedJson = box.get(_cacheKey);

    if (cachedJson != null && cachedJson.isNotEmpty) {
      try {
        final List<dynamic> list = jsonDecode(cachedJson);
        _cachedTypes = list.map((e) => DonationTypeModel.fromJson(e)).toList();

        emit(DonationTypesLoaded(_cachedTypes, fromCache: true));
        return;
      } catch (_) {
        emit(DonationTypesLoading());
      }
    } else {
      emit(DonationTypesLoading());
    }
  }

  /// Fetch fresh types from API and cache them
  Future<void> _fetchTypesFromApi() async {
    final result = await _dataSource.getDonationTypes();

    result.fold(
          (failure) {
        if (_cachedTypes.isNotEmpty) {
          emit(DonationTypesLoaded(_cachedTypes, fromCache: true));
        } else {
          emit(DonationTypesError(failure.errMessage));
        }
      },
          (response) async {
        final types = response.data;
        _cachedTypes = types;

        final box = await openHiveBox("donationTypesBox");
        await box.put(
          _cacheKey,
          jsonEncode(types.map((e) => e.toJson()).toList()),
        );

        emit(DonationTypesLoaded(types, fromCache: false));
      },
    );
  }
}
