import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/network/local/hive_data_base.dart';
import 'package:tua/feature/cart/data/models/user_info_response_model.dart';
import 'package:tua/feature/cart/data/data_source/get_user_info_data_source.dart';

import 'get_user_info_state.dart';


class UserInfoCubit extends Cubit<GetUserInfoState> {
  final GetUserInfoDataSource _dataSource;

  UserInfoCubit(this._dataSource) : super(GetUserInfoInitial());

  /// 👉 Public variable as requested
  List<SecondaryUserModel> users = [];

  /// Public method to load user info
  Future<void> fetchUserInfo() async {
    await _loadCachedUsers();
    await _fetchUserInfoFromApi();
  }

  /// Load cached users from Hive first
  Future<void> _loadCachedUsers() async {
    emit(GetUserInfoLoading());

    final box = await openHiveBox('userInfoBox');
    final cachedJson = box.get('userInfoCacheKey');

    if (cachedJson != null && cachedJson.isNotEmpty) {
      try {
        final decoded = jsonDecode(cachedJson) as List<dynamic>;
        users = decoded.map((e) => SecondaryUserModel.fromJson(e)).toList();

        emit(GetUserInfoLoaded(users, fromCache: true));
        return;
      } catch (e) {
        emit(GetUserInfoLoading());
      }
    } else {
      emit(GetUserInfoLoading());
    }
  }

  /// Fetch fresh data from API
  Future<void> _fetchUserInfoFromApi() async {
    final result = await _dataSource.getUserInfo();

    result.fold(
          (failure) {
        if (users.isNotEmpty) {
          emit(GetUserInfoLoaded(users, fromCache: true));
        } else {
          emit(GetUserInfoError(failure.errMessage));
        }
      },
          (freshUsers) async {
        users = freshUsers;

        final box = await openHiveBox('userInfoBox');
        final jsonList = users.map((u) => u.toJson()).toList();
        await box.put('userInfoCacheKey', jsonEncode(jsonList));

        emit(GetUserInfoLoaded(users, fromCache: false));
      },
    );
  }
}
