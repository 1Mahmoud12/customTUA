// ignore_for_file: type_annotate_public_apis
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/network/end_points.dart';
import 'package:tua/core/utils/constants.dart';

// ignore: avoid_classes_with_only_static_members
class DioHelper {
  static Dio? dio;

  // ignore: always_declare_return_types
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    // Accept expired/self-signed certificates for known dev domains in debug only
    assert(() {
      final Set<String> allowedHosts = {Uri.parse(EndPoints.domain).host, Uri.parse(EndPoints.baseUrl).host};

      dio!.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final HttpClient client = HttpClient();
          client.badCertificateCallback = (X509Certificate cert, String host, int port) {
            return allowedHosts.contains(host);
          };
          return client;
        },
      );
      return true;
    }());
  }

  // get dataSource ====>>>
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    BuildContext? context,
    String? isolateToken,
  }) async {
    final String token = isolateToken ?? Constants.token;
    debugPrint('token: $token');
    dio!.options.headers = {if (token.isNotEmpty) 'Authorization': 'Bearer $token', 'Content-Type': 'application/json', 'Accept': 'application/json'};
    log('=======================================================');
    log('${dio?.options.baseUrl}$url');
    log('َQuery ====> $query');
    log('Headers in get method ${dio!.options.headers}');

    log('=======================================================');
    query ??= {};
    data ??= {};
    query.addAll({'lang': arabicLanguage ? 'ar' : 'en'});
    data.addAll({'access_token': token});
    return dio!.get(url, queryParameters: query, data: data).then((value) {
      return value;
    });
  }

  // post dataSource ====>>>
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    bool formDataIsEnabled = false,
    String? jsonEncode,
    BuildContext? context,
    Options? options,
    bool? isolateToken = false,
  }) async {
    final String token = isolateToken! ? '' : Constants.token;

    dio!.options.headers = {if (token.isNotEmpty) 'Authorization': 'Bearer $token', 'Content-Type': 'application/json', 'Accept': 'application/json'};

    log('=======================================================');
    log('the endpoint ${dio!.options.baseUrl}$url');
    log('Headers in post method ${dio!.options.headers}');
    log('Data in post method ');
    if (formDataIsEnabled) {
      final FormData formData = FormData.fromMap(data ?? {});

      for (final field in formData.fields) {
        log('Field: ${field.key}: ${field.value}');
      }

      for (final file in formData.files) {
        log('File: ${file.key}: ${file.value.filename}, ${file.value.contentType}');
      }
    } else {
      log('data in post==>$data');
    }

    log('=======================================================');
    query ??= {};
    // data ??= {};
    query.addAll({'lang': arabicLanguage ? 'ar' : 'en'});
    //  data.addAll({'access_token': token});
    return dio!.post(
      '${EndPoints.baseUrl}$url',
      queryParameters: query,
      data: (formDataIsEnabled ? FormData.fromMap(data!) : data),
      options: options,
    );
  }

  // putData ====>>>
  static Future<Response> putData({
    required String endPoint,
    Map<String, dynamic>? query,
    bool formDataIsEnabled = false,
    required Map<String, dynamic> data,
    bool? isOrganization = true,
  }) async {
    final String token = Constants.token;
    dio!.options.headers = {
      'Authorization': 'Bearer ${Constants.token}',
      'Accept': 'application/json',
      if (formDataIsEnabled) 'Content-Type': 'application/json',
    };
    log('=======================================================');
    log('Headers in put method ${dio!.options.baseUrl}/$endPoint');
    log('Headers in put method ${dio!.options.headers}');

    log('Data in post method ');
    if (formDataIsEnabled) {
      final FormData formData = FormData.fromMap(data);

      for (final field in formData.fields) {
        log('Field: ${field.key}: ${field.value}');
      }

      for (final file in formData.files) {
        log('File: ${file.key}: ${file.value.filename}, ${file.value.contentType}');
      }
    } else {
      log('data in post==>$data');
    }
    query ??= {};

    query.addAll({'lang': arabicLanguage ? 'ar' : 'en'});
    data.addAll({'access_token': token});
    return dio!.put(endPoint, queryParameters: query, data: (formDataIsEnabled ? FormData.fromMap(data) : data)).then((value) {
      if (value.data['status'] == 0) {
        throw value.data['detail'];
      }
      debugPrint('Success Data (${value.data['StatusCode']}) ===> ${value.data['Data']}');
      return value;
    });
  }

  // deleteData ====>>>
  static Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? query,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? data,
  }) async {
    final String token = Constants.token;

    // final String token = HiveReuse.mainBox.get(AppConst.tokenBox) ?? '';
    dio!.options.headers = {if (token.isNotEmpty) 'Authorization': 'Bearer $token', 'Content-Type': 'application/json', 'Accept': 'application/json'};
    log('=======================================================');
    log('Headers in delete method ${dio!.options.baseUrl}/$endPoint');
    log('Headers in delete method ${dio!.options.headers}');
    log('Data in delete method $data');
    log('=======================================================');
    query ??= {};
    data ??= {};
    query.addAll({'lang': arabicLanguage ? 'ar' : 'en'});
    data.addAll({'access_token': token});
    return dio!.delete(endPoint, queryParameters: query, data: formDataIsEnabled ? FormData.fromMap(data) : data).then((value) {
      if (value.data['status'] == 0) {
        throw value.data['detail'];
      }
      debugPrint('Success Data (${value.data['StatusCode']}) ===> ${value.data['Data']}');
      return value;
    });
  }
}
