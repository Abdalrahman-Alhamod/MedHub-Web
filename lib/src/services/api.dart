import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as get_lib;
import 'package:dio/dio.dart';

import '../../main.dart';

class MethodType {
  const MethodType._();
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
}

class Api {
  const Api._();
  static const String baseUrl = 'http://127.0.0.1:8000/';

  static Future<dynamic> request({
    required String url,
    @required dynamic body,
    @required String? token,
    required String methodType,
    Map<String, String> headers = const {},
    dynamic image,
    String? lang,
  }) async {
    Map<String, String> requestHeaders = {};
    requestHeaders.addAll(
      {
        'token': token ?? "",
        'lang': lang ?? get_lib.Get.locale.toString(),
      },
    );
    requestHeaders.addAll(headers);

    final dio = Dio();
    try {
      FormData formData = FormData.fromMap(body.cast<String, dynamic>());

      if (image != null && image != "") {
        formData.files.add(MapEntry<String, MultipartFile>('image', image));
      } else if (image != null) {
        formData.fields.add(MapEntry<String, String>('image', image));
      }

      Response response = await dio.request(
        baseUrl + url,
        data: formData,
        options: Options(
          headers: requestHeaders,
          method: methodType,
        ),
      );

      return response.data;
    } on DioException catch (exception) {
      logger.e("API Dio Exception : $exception");
      logger.e("${exception.response}");
      if (exception.toString().contains('SocketException')) {
        throw DioException(
            message: "networkError".tr, requestOptions: RequestOptions());
      } else if (exception.type == DioExceptionType.receiveTimeout ||
          exception.type == DioExceptionType.connectionTimeout) {
        throw DioException(
            message: "connectionTimeOut".tr, requestOptions: RequestOptions());
      } else {
        dynamic jsonData, erroMessage;
        try {
          jsonData = jsonDecode(exception.response.toString());
          erroMessage = jsonData['message'];
        } catch (e) {
          throw DioException(
              message: "somthingWrongHappend".tr,
              requestOptions: RequestOptions());
        }
        throw DioException(
            message: erroMessage, requestOptions: RequestOptions());
      }
    } catch (e) {
      logger.e("API General Exception : $e");
      throw Exception(e.toString());
    }
  }
}
