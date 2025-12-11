import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/core/network/local/cache.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../models/donation_history_filter_params.dart';
import '../models/donations_history_response.dart';

class DonationsHistoryDataSource {
  Future<Either<Failure, DonationsHistoryResponse>> getDonationsHistory({
    DonationHistoryFilterParams? params,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.getDonationsHistory,
        query: params?.toJson(),
        data: {
          'access_token':userCacheValue?.accessToken??''
        },

      );
      final resultModel = DonationsHistoryResponse.fromJson(response.data);
      if (resultModel.success) {
        return right(resultModel);
      } else {
        return Left(ServerFailure(resultModel.message));
      }
    } catch (error) {
      log('error getDonationsHistory == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
