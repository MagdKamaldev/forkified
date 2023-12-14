import 'package:dio/dio.dart';

const String serverIp = "http://192.168.1.4:8080/";

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: serverIp,
          receiveDataWhenStatusError: true,
          headers: {
            "Content-Type": "application/json",
          }),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = "en",
    String? jwt,
  }) async {
    dio!.options.headers = {
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postDataBytes({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? jwt,
  }) async {
    dio!.options.headers = {
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };
    dio!.options.responseType = ResponseType.bytes;
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
    String? jwt,
  }) async {
    dio!.options.headers = {
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> updateData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
    String? jwt,
  }) async {
    dio!.options.headers = {
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };

    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? jwt,
  }) async {
    dio!.options.headers = {
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };

    return dio!.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
