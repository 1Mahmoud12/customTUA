import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/feature/home/data/model/change_currency_response.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';

class HomeDataSource {
  Future<Either<Failure, String>> getCurrency() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getCurrency);

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

  Future<Either<Failure, ChangeCurrencyResponse>> changeCurrency(String currency) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.changeCurrency,
        data: {'currency': currency},
      );

      if (response.statusCode == 200) {
        final responseModel = ChangeCurrencyResponse.fromJson(response.data);

        if (responseModel.success == true) {
          return right(responseModel);
        } else {
          return Left(ServerFailure(responseModel.message));
        }
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (error) {
      log('error changeCurrency == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
