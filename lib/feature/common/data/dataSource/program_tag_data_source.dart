import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/dio_helper.dart';
import 'package:tua/core/network/end_points.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/feature/common/data/models/program_tag_model.dart';

class ProgramTagDataSource {
  static Future<Either<Failure, ProgramTagResponseModel>> fetchProgramTags() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getProgramsTag);
      return right(ProgramTagResponseModel.fromJson(response.data));
    } catch (error) {
      log('error fetchProgramTags==$error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}

