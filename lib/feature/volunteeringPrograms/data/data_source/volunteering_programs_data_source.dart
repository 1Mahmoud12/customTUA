import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/dio_helper.dart';
import 'package:tua/core/network/end_points.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/core/utils/utils.dart';
import 'package:tua/feature/volunteeringPrograms/data/models/donation_campaign_request_model.dart';
import 'package:tua/feature/volunteeringPrograms/data/models/volunteering_program_model.dart';

class VolunteeringProgramsDataSource {
  Future<Either<Failure, VolunteeringProgramsResponseModel>> getVolunteeringPrograms() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getVolunteeringPrograms);
      return right(VolunteeringProgramsResponseModel.fromJson(response.data));
    } catch (error) {
      log('error getVolunteeringPrograms == $error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  Future<Either<Failure, VolunteeringProgramModel>> getVolunteeringProgramById(int id) async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getVolunteeringProgramById, query: {'id': id});

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final dataList = data['data'] as List;
          if (dataList.isNotEmpty) {
            return right(VolunteeringProgramModel.fromJson(dataList.first as Map<String, dynamic>));
          } else {
            return Left(ServerFailure('Program not found'));
          }
        } else {
          return Left(ServerFailure(data['message'] ?? 'Unexpected response'));
        }
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (error) {
      log('error getVolunteeringProgramById == $error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  Future<Either<Failure, Unit>> createDonationCampaign(DonationCampaignRequestModel request) async {
    try {
      final response = await DioHelper.postData(url: EndPoints.createDonationCampaign, formDataIsEnabled: true, data: request.toJson());

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true) {
          Utils.showToast(title: data['message'], state: UtilState.success);
          //   customShowToast(navigatorKey.currentState!.context, data['message']);
          return right(unit);
        } else {
          return Left(ServerFailure(data['message'] ?? 'Failed to create donation campaign'));
        }
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (error) {
      log('error createDonationCampaign == $error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
