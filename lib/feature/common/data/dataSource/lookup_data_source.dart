import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/dio_helper.dart';
import 'package:tua/core/network/end_points.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/feature/common/data/models/lookup_model.dart';

class LookupDataSource {
  static Future<Either<Failure, LookupModel>> fetchLookup() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.utilitiesLookup);
      return right(LookupModel.fromJson(response.data));
    } catch (error) {
      log('error lookup==$error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}


