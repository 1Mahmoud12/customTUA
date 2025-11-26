import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/core/network/local/cache.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../models/hyper_pay_checkout_response.dart';
import '../models/hyper_pay_config_response.dart';

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

  Future<Either<Failure, String>> hyperPayHandler(String checkoutId) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.hyperPayHandler,
        data: {'checkout_id': checkoutId, 'type': 'cart', 'access_token': userCacheValue?.accessToken ?? ''},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['success'] == true) {
          return right(data['message']);
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

  Future<Either<Failure, HyperPayConfigData>> getHyperPayConfig({String? lang}) async {
    try {
      final response = await DioHelper.getData(url: EndPoints.hyperPayConfig, query: lang != null ? {'lang': lang} : null);

      if (response.statusCode == 200) {
        final responseModel = HyperPayConfigResponse.fromJson(response.data);

        if (responseModel.success == true) {
          return right(responseModel.data);
        } else {
          return Left(ServerFailure(responseModel.message ?? 'Failed to get hyperPay config'));
        }
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (error) {
      log('error getHyperPayConfig == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
