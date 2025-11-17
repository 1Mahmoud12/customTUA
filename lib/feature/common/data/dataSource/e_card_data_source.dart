import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/dio_helper.dart';
import 'package:tua/core/network/end_points.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/feature/common/data/models/e_card_model.dart';

class ECardDataSource {
  static Future<Either<Failure, ECardsResponseModel>> fetchECards() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getECards);
      return right(ECardsResponseModel.fromJson(response.data));
    } catch (error) {
      log('error fetchECards==$error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  static Future<Either<Failure, Unit>> sendECard({
    required String amount,
    required String senderName,
    required String recipientName,
    required String senderEmail,
    required String senderMobileNumber,
    required String recipientEmail,
    required String recipientMobileNumber,
    required String donorId,
    required String eCardId,
    required String message,
    required String sendWhenFinished,
    required String startDate,
  }) async {
    try {
      final data = {
        'amount': amount,
        'sender_name': senderName,
        'recipient_name': recipientName,
        'sender_email': senderEmail,
        'sender_mobile_number': senderMobileNumber,
        'recipient_email': recipientEmail,
        'recipient_mobile_number': recipientMobileNumber,
        'donor_id': donorId,
        'e_card_id': eCardId,
        'message': message,
        'send_when_finished': sendWhenFinished,
        'start_date': startDate,
      };

      final response = await DioHelper.postData(
        url: EndPoints.sendECard,
        formDataIsEnabled: true,
        data: data,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          return right(unit);
        } else {
          return Left(ServerFailure(responseData['message'] ?? 'Failed to send e-card'));
        }
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } catch (error) {
      log('error sendECard==$error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}

