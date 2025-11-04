import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/dio_helper.dart';
import 'package:tua/core/network/end_points.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/feature/home/data/model/slider_model.dart';

abstract class HomeDataSource {
  Future<Either<Failure, SliderModel>> getSlider();
}

class HomeDataSourceImpl implements HomeDataSource {
  @override
  Future<Either<Failure, SliderModel>> getSlider() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getAllSlider);
      return Right(SliderModel.fromJson(response.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
