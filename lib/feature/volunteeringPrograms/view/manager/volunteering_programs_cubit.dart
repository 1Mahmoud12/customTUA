import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/network/local/hive_data_base.dart';
import 'package:tua/core/utils/constants_models.dart';
import 'package:tua/feature/home/data/homeDataSource/home_data_source.dart';
import 'package:tua/feature/home/data/model/slider_model.dart';
import 'package:tua/feature/volunteeringPrograms/data/data_source/volunteering_programs_data_source.dart';
import 'package:tua/feature/volunteeringPrograms/data/models/volunteering_program_model.dart';

part 'volunteering_programs_state.dart';

class VolunteeringProgramsCubit extends Cubit<VolunteeringProgramsState> {
  final VolunteeringProgramsDataSource _dataSource;
  final HomeDataSource _homeDataSource;

  VolunteeringProgramsCubit(this._dataSource, this._homeDataSource)
      : super(VolunteeringProgramsInitial());

  List<VolunteeringProgramModel> _cachedPrograms = [];
  List<SliderData> _cachedFirstSection = [];
  List<SliderData> _cachedThirdSection = [];

  // Getters for cached data
  List<VolunteeringProgramModel> get cachedPrograms => _cachedPrograms;
  List<SliderData> get cachedFirstSection => _cachedFirstSection;
  List<SliderData> get cachedThirdSection => _cachedThirdSection;

  /// Public method to load all data
  Future<void> loadAllData() async {
    await _loadCachedData();
    await _fetchDataFromApi();
  }

  /// Load data from Hive cache first
  Future<void> _loadCachedData() async {
    emit(VolunteeringProgramsLoading());
    final box = await openHiveBox('volunteeringBox');

    try {
      // Load cached programs
      final cachedProgramsJson = box.get('programsCacheKey');
      if (cachedProgramsJson != null && cachedProgramsJson.isNotEmpty) {
        final programsList = (jsonDecode(cachedProgramsJson) as List)
            .map((e) => VolunteeringProgramModel.fromJson(e))
            .toList();
        _cachedPrograms = programsList;
      }

      // Load cached first section
      final cachedFirstJson = box.get('firstSectionCacheKey');
      if (cachedFirstJson != null && cachedFirstJson.isNotEmpty) {
        final firstList = (jsonDecode(cachedFirstJson) as List)
            .map((e) => SliderData.fromJson(e))
            .toList();
        _cachedFirstSection = firstList;
      }

      // Load cached third section
      final cachedThirdJson = box.get('thirdSectionCacheKey');
      if (cachedThirdJson != null && cachedThirdJson.isNotEmpty) {
        final thirdList = (jsonDecode(cachedThirdJson) as List)
            .map((e) => SliderData.fromJson(e))
            .toList();
        _cachedThirdSection = thirdList;
      }

      // Emit cached data if available
      if (_cachedPrograms.isNotEmpty ||
          _cachedFirstSection.isNotEmpty ||
          _cachedThirdSection.isNotEmpty) {
        emit(VolunteeringProgramsLoaded(
          programs: _cachedPrograms,
          firstSection: _cachedFirstSection,
          thirdSection: _cachedThirdSection,
          fromCache: true,
        ));
      } else {
        emit(VolunteeringProgramsLoading());
      }
    } catch (e) {
      emit(VolunteeringProgramsLoading());
    }
  }

  /// Fetch fresh data from API and cache it
  Future<void> _fetchDataFromApi() async {
    List<VolunteeringProgramModel> programs = [];
    List<SliderData> firstSectionData = [];
    List<SliderData> thirdSectionData = [];

    // Load programs
    final programsResult = await _dataSource.getVolunteeringPrograms();
    programsResult.fold(
          (failure) {
        // Keep cached data if API fails
        if (_cachedPrograms.isEmpty) {
          emit(VolunteeringProgramsError(failure.errMessage));
        }
      },
          (response) {
        programs = response.data;
      },
    );

    // Load sections in parallel
    await Future.wait([
      _loadFirstSection().then((data) => firstSectionData = data),
      _loadThirdSection().then((data) => thirdSectionData = data),
    ]);

    // Update cache
    _cachedPrograms = programs;
    _cachedFirstSection = firstSectionData;
    _cachedThirdSection = thirdSectionData;

    // Save to Hive
    await _saveToCache(programs, firstSectionData, thirdSectionData);

    // Emit fresh data
    emit(VolunteeringProgramsLoaded(
      programs: programs,
      firstSection: firstSectionData,
      thirdSection: thirdSectionData,
      fromCache: false,
    ));
  }

  /// Load first section data
  Future<List<SliderData>> _loadFirstSection() async {
    final bmsCategories = ConstantsModels.lookupModel?.data?.bmsCategories;

    if (bmsCategories == null || bmsCategories.isEmpty) {
      return [];
    }

    // Get "about-volunteer-first-section" key
    final categorySlug = bmsCategories.keys.firstWhere(
          (key) => key.contains('first-section'),
      orElse: () => bmsCategories.keys.elementAt(1),
    );

    final result = await _homeDataSource.getSlider(
      limit: 10,
      categorySlug: categorySlug,
    );

    return result.fold(
          (failure) => [],
          (response) => response.data ?? [],
    );
  }

  /// Load third section data
  Future<List<SliderData>> _loadThirdSection() async {
    final bmsCategories = ConstantsModels.lookupModel?.data?.bmsCategories;

    if (bmsCategories == null || bmsCategories.isEmpty) {
      return [];
    }

    // Get "about-volunteer-third-section" key
    final categorySlug = bmsCategories.keys.firstWhere(
          (key) => key.contains('third-section'),
      orElse: () => bmsCategories.keys.elementAt(2),
    );

    final result = await _homeDataSource.getSlider(
      limit: 10,
      categorySlug: categorySlug,
    );

    return result.fold(
          (failure) => [],
          (response) => response.data ?? [],
    );
  }

  /// Save all data to cache
  Future<void> _saveToCache(
      List<VolunteeringProgramModel> programs,
      List<SliderData> firstSection,
      List<SliderData> thirdSection,
      ) async {
    try {
      final box = await openHiveBox('volunteeringBox');

      // Save programs
      if (programs.isNotEmpty) {
        final programsJson = jsonEncode(programs.map((e) => e.toJson()).toList());
        await box.put('programsCacheKey', programsJson);
      }

      // Save first section
      if (firstSection.isNotEmpty) {
        final firstJson = jsonEncode(firstSection.map((e) => e.toJson()).toList());
        await box.put('firstSectionCacheKey', firstJson);
      }

      // Save third section
      if (thirdSection.isNotEmpty) {
        final thirdJson = jsonEncode(thirdSection.map((e) => e.toJson()).toList());
        await box.put('thirdSectionCacheKey', thirdJson);
      }
    } catch (e) {
      // Handle cache save error silently
    }
  }

  /// Clear cache
  Future<void> clearCache() async {
    try {
      final box = await openHiveBox('volunteeringBox');
      await box.delete('programsCacheKey');
      await box.delete('firstSectionCacheKey');
      await box.delete('thirdSectionCacheKey');

      _cachedPrograms = [];
      _cachedFirstSection = [];
      _cachedThirdSection = [];
    } catch (e) {
      // Handle clear cache error silently
    }
  }

  /// Refresh data (force fetch from API)
  Future<void> refreshData() async {
    await loadAllData();
  }
}