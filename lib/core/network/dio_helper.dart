import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jolz_app/core/cache/cache_helper.dart';

import '../api/api_config.dart';
import '../errors/exceptions.dart';

class DioHelper {
  static late Dio _dio;
  static String? _token;

  static Future<void> init() async {
    _dio = Dio();
    if (CacheHelper.containsKey('token')) {
      _token = CacheHelper.getString('token');
    }
    _initApiClient();
  }

  static void _initApiClient() {
    if (_token != null) {
      _dio.options.headers["Authorization"] = "Bearer $_token";
    }
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.baseUrl = ApiConfig.baseUrl;
    _dio.options.responseType = ResponseType.plain;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) async {
      try {
        if (error.response?.statusCode == 401) {
          final newAccessToken =
              await FirebaseAuth.instance.currentUser?.getIdToken(true);
          if (newAccessToken == null) {
            return handler.next(error);
          }
          await setToken(newAccessToken);
          final response = await _dio.request(
            error.requestOptions.path,
            cancelToken: error.requestOptions.cancelToken,
            data: error.requestOptions.data,
            onReceiveProgress: error.requestOptions.onReceiveProgress,
            onSendProgress: error.requestOptions.onSendProgress,
            queryParameters: error.requestOptions.queryParameters,
          );
          handler.resolve(response);
        } else {
          return handler.next(error);
        }
      } catch (e) {
        removeToken();
        removeRefreshToken();
        return handler.next(error);
      }
    }));
  }

  static bool get isLoggedIn {
    return _token != null;
  }

  static Future<void> setToken(String token) async {
    await CacheHelper.setString('token', token);
    _token = token;
    _dio.options.headers["Authorization"] = "Bearer $_token";
    print('Access token set');
  }

  static Future<void> setTokenHeader() async {
    _dio.options.headers["Authorization"] = "Bearer $_token";
    print('Access token set');
  }

  static Future<void> setRefreshToken(String token) async {
    await CacheHelper.setString('refresh-token', token);
    print('Refresh token set');
  }

  static void removeToken() {
    CacheHelper.remove('token');
    _token = null;
    _dio.options.headers["Authorization"] = null;
    print('Access token removed');
  }

  static void removeTokenHeader() {
    _dio.options.headers["Authorization"] = null;
    print('Access token removed');
  }

  static void removeRefreshToken() {
    CacheHelper.remove('refresh-token');
    print('Refresh token removed');
  }

  static Future<String> get(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print(
          'GET request => url:$url, body: $body, queryParameters: $queryParameters');
      final response =
          await _dio.get(url, queryParameters: queryParameters, data: body);
      if (response.statusCode != 200) {
        throw ServerException(
            statusCode: response.statusCode, error: response.data);
      }
      return response.data;
    } on DioException catch (e) {
      print(e.response?.data);
      print('GET error Connection Exception => ${e.message}');
      throw ServerException(
          statusCode: e.response?.statusCode, error: e.response?.data);
    }
  }

  static Future<dynamic> post(String url,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      int doneStatusCode = 201}) async {
    try {
      print('options: ${_dio.options.headers}');
      print(
          'POST request => url:$url, body: $body, queryParameters: $queryParameters');
      final response =
          await _dio.post(url, queryParameters: queryParameters, data: body);
      print(response.statusCode);
      if (response.statusCode != doneStatusCode && response.statusCode != 200) {
        throw ServerException(
            statusCode: response.statusCode, error: response.data);
      }
      return response.data;
    } on DioException catch (e) {
      print(e.response?.data);
      print('POST error Connection Exception => ${e.message}');
      throw ServerException(
          statusCode: e.response?.statusCode, error: e.response?.data);
    }
  }

  static Future<dynamic> put(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print(
          'PUT request => url:$url, body: $body, queryParameters: $queryParameters');
      final response =
          await _dio.put(url, queryParameters: queryParameters, data: body);
      if (response.statusCode != 200) {
        throw ServerException(
            statusCode: response.statusCode, error: response.data);
      }
      return response.data;
    } on DioException catch (e) {
      print('PUT error Connection Exception => ${e.message}');
      throw ServerException(
          statusCode: e.response?.statusCode, error: e.response?.data);
    }
  }

  static Future<dynamic> patch(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print(
          'PATCH request => url:$url, body: $body, queryParameters: $queryParameters');
      final response =
          await _dio.patch(url, queryParameters: queryParameters, data: body);
      if (response.statusCode != 200) {
        throw ServerException(
            statusCode: response.statusCode, error: response.data);
      }
      return response.data;
    } on DioException catch (e) {
      print(
          'PATCH error Connection Exception => ${e.message} ${e.error} ${e.response?.data}');
      throw ServerException(
          statusCode: e.response?.statusCode, error: e.response?.data);
    }
  }

  static Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print(
          'DELETE request => url:$url, body: $body, queryParameters: $queryParameters');
      final response =
          await _dio.delete(url, queryParameters: queryParameters, data: body);
      if (response.statusCode != 200) {
        throw ServerException(
            statusCode: response.statusCode, error: response.data);
      }
      return response.data;
    } on DioException catch (e) {
      print('DELETE error Connection Exception => ${e.message}');
      throw ServerException(
          statusCode: e.response?.statusCode, error: e.response?.data);
    }
  }

  static Future<dynamic> upload(String url, String filePath,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      Function(double progress)? onUploadProgress,
      int doneStatusCode = 201}) async {
    try {
      print('options: ${_dio.options.headers}');
      print(
          'UPLOAD request => url:$url, body: $body, queryParameters: $queryParameters');
      String fileName = filePath.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath, filename: fileName),
        ...body!
      });
      final response = await _dio.post(url,
          queryParameters: queryParameters,
          data: formData,
          onSendProgress: onUploadProgress != null
              ? (count, total) => onUploadProgress(count / total)
              : null,
          options: Options(headers: {
            "Content-Type": "multipart/form-data",
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "OPTIONS,POST,GET",
            "Authorization": null,
          }));
      print(response.statusCode);
      if (response.statusCode != doneStatusCode && response.statusCode != 201) {
        throw ServerException(
            statusCode: response.statusCode, error: response.data);
      }
      return response.data;
    } on DioException catch (e) {
      print(e.response?.data);
      print('POST error Connection Exception => ${e.message}');
      throw ServerException(
          statusCode: e.response?.statusCode, error: e.response?.data);
    }
  }
}
