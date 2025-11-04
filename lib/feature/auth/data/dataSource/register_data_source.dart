import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/dio_helper.dart';
import 'package:tua/core/network/end_points.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/feature/auth/data/models/login_model.dart';
import 'package:tua/feature/auth/data/models/register_params.dart';

class RegisterDataSource {
  static Future<Either<Failure, LoginModel>> register({required RegisterParams data}) async {
    try {
      final response = await DioHelper.postData(url: EndPoints.register, data: data.toJson());
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
