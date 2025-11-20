import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/feature/cart/data/data_source/cart_data_source.dart';
import 'package:tua/feature/cart/data/models/add_cart_item_parms.dart';
import 'package:tua/feature/cart/data/models/cart_items_response_model.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';

class CartDataSourceImpl implements CartDataSource {

  @override
  Future<Either<Failure, Unit>> addCartItems({required List<AddCartItemParms> params}) async {
    try {
      final body = <String, dynamic>{};

      for (int i = 0; i < params.length; i++) {
        body.addAll(params[i].toJson(index: i));
      }
      log('body == $body');

      final response = await DioHelper.postData(
        url: EndPoints.addToCart,
        formDataIsEnabled: true,
        data: body,
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['success'] == true && data['data'] != null) {
          return right(unit);
        } else {
          return Left(ServerFailure(data['message'] ?? 'Unexpected response'));
        }
      }

      return Left(ServerFailure('Server error: ${response.statusCode}'));
    } catch (error) {
      log('error addCartItems == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, CartItemsResponseModel>> getCartItems() async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.getCartItems,
        query: {'access_token': userCacheValue?.accessToken ?? ''},
        data: {'access_token': userCacheValue?.accessToken ?? ''},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['success'] == true && data['data'] != null) {
          return right(CartItemsResponseModel.fromJson(data));
        } else {
          return Left(ServerFailure(data['message'] ?? 'Unexpected response'));
        }
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (error) {
      log('error getCartItems == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeCartItem({required String uniqueKey}) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.deleteCartItem,
        // formDataIsEnabled: true,
        data: {'item_id': uniqueKey},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['success'] == true && data['data'] != null) {
          return right(unit);
        } else {
          return Left(ServerFailure(data['message'] ?? 'Unexpected response'));
        }
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (error) {
      log('error removeCartItem == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
