import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_source/basic_page_data_source.dart';
import '../../data/models/basic_page_model.dart';

import '../../../../core/network/local/hive_data_base.dart';
import 'basic_page_state.dart';

// Cache Key (you can rename if needed)
const String basicPageCacheBox = 'basicPageBox';
const String basicPageCacheKeyPrefix = 'basicPage_';

class BasicPageCubit extends Cubit<BasicPageState> {
  final BasicPageDataSource dataSource;

  BasicPageCubit(this.dataSource) : super(BasicPageInitial());

  BasicPageModel? _cachedPage;

  BasicPageModel? get cachedPage => _cachedPage;

  /// Public Method to get specific page by slug
  Future<void> fetchBasicPage(String slug) async {
    await _loadCachedPage(slug);
    await _fetchPageFromApi(slug);
  }

  /// Load from Hive Cache First
  Future<void> _loadCachedPage(String slug) async {
    emit(BasicPageLoading());

    final box = await openHiveBox(basicPageCacheBox);
    final cachedJson = box.get('$basicPageCacheKeyPrefix$slug');

    if (cachedJson != null && cachedJson.isNotEmpty) {
      try {
        final Map<String, dynamic> map = jsonDecode(cachedJson);
        _cachedPage = BasicPageModel.fromJson(map);
        emit(BasicPageLoaded(_cachedPage!, fromCache: true));
        return;
      } catch (e) {
        // corrupted cache fallback
        emit(BasicPageLoading());
      }
    } else {
      emit(BasicPageLoading());
    }
  }

  /// Fetch fresh page & cache it
  Future<void> _fetchPageFromApi(String slug) async {
    final result = await dataSource.getBasicPage(slug: slug);

    result.fold(
      (failure) {
        if (_cachedPage != null) {
          emit(BasicPageLoaded(_cachedPage!, fromCache: true));
        } else {
          emit(BasicPageError(failure.errMessage));
        }
      },
      (page) async {
        _cachedPage = page;

        final box = await openHiveBox(basicPageCacheBox);
        final encoded = jsonEncode(page.toJson());
        await box.put('$basicPageCacheKeyPrefix$slug', encoded);

        emit(BasicPageLoaded(page, fromCache: false));
      },
    );
  }
}
