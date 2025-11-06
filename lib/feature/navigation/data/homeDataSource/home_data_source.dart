import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/errors/failures.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';

class HomeDataSource {
  Future<Either<Failure, String>> getCurrency() async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.getCurrency,
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['success'] == true && data['data'] != null) {
          final currency = data['data']['currency'] as String;
          return right(currency);
        } else {
          return Left(ServerFailure(data['message'] ?? 'Unexpected response'));
        }
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (error) {
      log('error getCurrency == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
