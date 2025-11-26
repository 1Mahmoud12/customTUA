import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/feature/donations/data/data_source/donation_programs_data_source.dart';
import 'package:tua/feature/donations/data/models/donation_program_model.dart';

import '../../../../core/network/local/cache.dart';
import '../../../../core/network/local/hive_data_base.dart'; // where openHiveBox is

part 'donation_programs_state.dart';

class DonationProgramsCubit extends Cubit<DonationProgramsState> {
  final DonationProgramsDataSource _dataSource;

  DonationProgramsCubit(this._dataSource) : super(DonationProgramsInitial());

  List<DonationProgramModel> _cachedPrograms = [];

  List<DonationProgramModel> get cachedPrograms => _cachedPrograms;

  /// Public method to get donation programs
  Future<void> fetchDonationPrograms([String tag = '']) async {
    await _loadCachedPrograms();
    await _fetchProgramsFromApi(tag);
  }

  /// Load from Hive cache first
  Future<void> _loadCachedPrograms() async {

    final box = await openHiveBox('donationProgramsBox');
    final cachedJson = box.get(donationProgramsCacheKey);

    if (cachedJson != null && cachedJson.isNotEmpty) {
      try {
        final List<dynamic> list = jsonDecode(cachedJson);
        _cachedPrograms = list.map((e) => DonationProgramModel.fromJson(e)).toList();
        emit(DonationProgramsLoaded(_cachedPrograms, fromCache: true));
        return;
      } catch (e) {
        emit(DonationProgramsLoading());
      }
    } else {
      emit(DonationProgramsLoading());
    }
  }

  /// Fetch fresh programs from API and cache them
  Future<void> _fetchProgramsFromApi(String tag) async {
    emit(DonationProgramsLoading());

    final result = await _dataSource.getDonationPrograms(tag);

    result.fold(
      (failure) {
        if (_cachedPrograms.isNotEmpty) {
          emit(DonationProgramsLoaded(_cachedPrograms, fromCache: true));
        } else {
          emit(DonationProgramsError(failure.errMessage));
        }
      },
      (programs) async {
        _cachedPrograms = programs;

        final box = await openHiveBox('donationProgramsBox');
        final encoded = jsonEncode(programs.map((e) => e.toJson()).toList());
        await box.put(donationProgramsCacheKey, encoded);

        emit(DonationProgramsLoaded(programs, fromCache: false));
      },
    );
  }
}
