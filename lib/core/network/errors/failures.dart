import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/network/local/cache.dart';
import 'package:tua/core/utils/constants.dart';
import 'package:tua/feature/auth/views/presentation/login_view.dart';
import 'package:tua/main.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioException(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('connection_timeout'.tr());
      case DioExceptionType.sendTimeout:
        return ServerFailure('send_timeout'.tr());
      case DioExceptionType.receiveTimeout:
        return ServerFailure('receive_timeout'.tr());
      case DioExceptionType.badResponse:
        log('Bad response: ${dioError.response?.statusCode} ${dioError.response?.data}');
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
      case DioExceptionType.badCertificate:
        return ServerFailure('bad_certificate'.tr());
      case DioExceptionType.cancel:
        return ServerFailure('request_cancelled'.tr());
      case DioExceptionType.connectionError:
        return ServerFailure('no_internet_connection'.tr());
      case DioExceptionType.unknown:
        return ServerFailure('unexpected_error'.tr());
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403 || statusCode == 422 || statusCode == 302) {
      if (response != null && response['message'] != null) {
        final msg = response['message'].toString().toLowerCase();
        if (msg.contains('token is expired') || msg.contains('authorization token not found')) {
          try {
            Future.delayed(Duration.zero, () {
              navigatorKey.currentState!.pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            });
            Constants.token = '';
            userCache?.put(userCacheKey, '{}');
          } catch (e) {
            log('Error saving empty user cache: $e');
          }
        }
        return ServerFailure('server_error_message'.tr(args: [response['message'].toString()]));
      }
    }

    switch (statusCode) {
      case 404:
        return ServerFailure('request_not_found'.tr());
      case 500:
        return ServerFailure('internal_server_error'.tr());
      default:
        return ServerFailure('generic_error'.tr());
    }
  }
}
