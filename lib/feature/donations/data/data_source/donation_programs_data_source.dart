import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/errors/failures.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../models/donation_program_details_model.dart';
import '../models/donation_program_model.dart';

class DonationProgramsDataSource {
  Future<Either<Failure, List<DonationProgramModel>>> getDonationPrograms() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getDonationPrograms);

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List dataList = response.data['data'] ?? [];
        final programs = dataList.map((e) => DonationProgramModel.fromJson(e)).toList();
        return right(programs);
      } else {
        return Left(ServerFailure(response.data['message'] ?? 'Unexpected error'));
      }
    } catch (error) {
      log('error getDonationPrograms == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<Either<Failure, DonationProgramDetailsModel>> getDonationProgramById(int id) async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.getDonationProgramById,
        query: {'id': id,},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        return right(DonationProgramDetailsModel.fromJson(data));
      } else {
        return left(ServerFailure(response.data['message'] ?? 'Unexpected error'));
      }
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

}
