import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/errors/failures.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';

class ResetPasswordDataSource {
   Future<Either<Failure, Unit>> resetPassword({
    required String password,
    required String confirmPassword,
    required String otp,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.resetPassword,
        data: {'password': password, 'repeat_password': confirmPassword, 'otp': otp},
      );
      if (response.statusCode == 200 && response.data['status'] == false) {
        return Left(ServerFailure(response.data['message']));
      } else {
        return right(unit);
      }
    } catch (error) {
      log('error resetPassword == $error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

   Future<Either<Failure, Unit>> requestResetPassword({required String email}) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.requestResetPassword,
        data: {'username': email},
      );
      if (response.statusCode == 200 && response.data['status'] == false) {
        return Left(ServerFailure(response.data['message']));
      } else {
        return right(unit);
      }
    } catch (error) {
      log('error requestResetPassword == $error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
