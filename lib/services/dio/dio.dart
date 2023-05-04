import 'package:dio/dio.dart';

import '../../constants/endpoints.dart';
import 'logger/authorization_interceptor.dart';
import 'logger/logger_interceptor.dart';

class DioClient{
  final Dio dio = Dio(BaseOptions(
    baseUrl: Endpoints.baseUrl,
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
    validateStatus: (_) => true,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ))..interceptors.addAll([
    AuthorizationInterceptor(),
    LoggerInterceptor(),
  ]);
}