import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/feature/cart/data/models/user_info_response_model.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/errors/failures.dart';

class GetUserInfoDataSource {
  Future<Either<Failure, List<SecondaryUserModel>>> getUserInfo() async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.getProfileInfo,
        data: {'access_token': userCacheValue?.accessToken ?? ''},
      );
      final responseModel = UserInfoResponseModel.fromJson(response.data);

      if (responseModel.success) {
        return right(responseModel.data.secondaryUsers);
      } else {
        log('error getUserInfo == ${response.statusCode}');
        return Left(ServerFailure(responseModel.message ?? 'Unexpected response'));
      }
    } catch (error) {
      log('error getUserInfo == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
