import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/feature/auth/data/models/login_model.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import 'profile_details_data_source.dart';

class ProfileDetailsDataSourceImpl implements ProfileDetailsDataSource {
  @override
  Future<Either<Failure, Unit>> changePassword({required String password, required String newPassword, required String confirmNewPassword}) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.changePassword,
        data: {
          'password': password,
          'new_password': newPassword,
          'confirm_new_password': confirmNewPassword,
          'access_token': userCacheValue?.accessToken ?? '',
        },
      );
      // API now returns `success` flag in body
      if (response.statusCode == 200 && response.data['success'] == false) {
        return Left(ServerFailure(response.data['message']));
      }
      return right(unit);
    } catch (error) {
      log('error changePassword==$error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> updateProfile({required String firstName, required String lastName, required String phone}) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.updateProfile,
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': userCacheValue?.email ?? '',
          'access_token': userCacheValue?.accessToken ?? '',
          'phone': phone,
        },
      );
      // API now returns `success` flag in body
      if (response.statusCode == 200 && response.data['success'] == false) {
        return Left(ServerFailure(response.data['message']));
      }
      return right(LoginModel.fromJson(response.data));
    } catch (error) {
      log('error updateProfile==$error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
