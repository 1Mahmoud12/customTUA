import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/errors/failures.dart';
import '../models/basic_page_model.dart';
import '../models/basic_page_response_model.dart';

class BasicPageDataSource {
  Future<Either<Failure, BasicPageModel>> getBasicPage({required String slug}) async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getBasicPage, query: {'slug': slug});

      final responseModel = BasicPageResponseModel.fromJson(response.data);

      if (responseModel.success) {
        return Right(responseModel.data);
      } else {
        log('error basicPage == ${response.statusCode}');
        return Left(ServerFailure(responseModel.message ?? 'Unexpected response'));
      }
    } catch (error) {
      log('error basicPage == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
