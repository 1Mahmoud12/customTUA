import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/dio_helper.dart';
import 'package:tua/core/network/end_points.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/feature/auth/data/models/login_model.dart';

class LoginDataSource {
  static Future<Either<Failure, LoginModel>> login({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.login,
        data: data,
      );
      // API now returns `success` flag in body
      if (response.statusCode == 200 && response.data['success'] == false) {
        return Left(ServerFailure(response.data['message']));
      }
      return right(LoginModel.fromJson(response.data));
    } catch (error) {
      log('error register==$error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
