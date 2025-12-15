import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tua/core/network/errors/failures.dart';
import 'package:tua/feature/cardSetting/data/models/save_card_response.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/local/cache.dart';
import '../models/get_cards_response.dart';

class CardSettingsDataSource {
  Future<Either<Failure, SaveCardResponse>> saveCard() async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.saveCard,
        data: {'access_token': userCacheValue?.accessToken ?? ''},
      );
      final responseModel = SaveCardResponse.fromJson(response.data);
      if (responseModel.success) {
        return right(responseModel);
      } else {
        return Left(ServerFailure(responseModel.message));
      }
    } catch (error) {
      log('error saveCard == $error');

      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  Future<Either<Failure, List<CardInfo>>> getCards() async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.getCards,
        data: {'access_token': userCacheValue?.accessToken ?? ''},
      );
      final responseModel = GetCardsResponse.fromJson(response.data);
      if (responseModel.success) {
        return right(responseModel.data.cards);
      } else {
        return Left(ServerFailure(responseModel.message));
      }
    } catch (error) {
      log('error getCards == $error');
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}