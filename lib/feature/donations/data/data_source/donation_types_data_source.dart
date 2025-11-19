import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/dio_helper.dart';
import 'package:tua/core/network/end_points.dart';
import 'package:tua/core/network/errors/failures.dart';

import '../models/donation_type_model.dart';

class DonationTypesDataSource {
  Future<Either<Failure, DonationTypesResponseModel>> getDonationTypes() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getDonationsTypes);

      if (response.statusCode == 200) {
        final data = response.data;
        return Right(DonationTypesResponseModel.fromJson(data));
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (error) {
      log('error getDonationTypes == $error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
