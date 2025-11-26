import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/core/network/local/cache.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../models/hyper_pay_checkout_response.dart';

class HyperPayDataSource {
  Future<Either<Failure, HyperPayCheckoutInner>> hyperPayCheckout() async {
    try {
      final response = await DioHelper.postData(url: EndPoints.hyperPayCheckout);

      if (response.statusCode == 200) {
        final responseModel = HyperPayCheckoutResponse.fromJson(response.data);

        if (responseModel.success == true) {
          return right(responseModel.data.checkout.data);
        } else {
          return Left(ServerFailure(responseModel.message ?? 'Failed to hyperPayCheckout'));
        }
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (error) {
      log('error hyperPayCheckout == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  Future<Either<Failure, Unit>> hyperPayHandler(String checkoutId) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.hyperPayHandler,
        data: {
          'checkout_id': checkoutId,
          'type': 'cart',
          'access_token': userCacheValue?.accessToken ?? '',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['success'] == true) {
          return right(unit);
        } else {
          return Left(ServerFailure(data['message'] ?? 'Failed to hyperPayHandler'));
        }
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (error) {
      log('error hyperPayHandler == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
