import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';


var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 175,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

// Define an enum for the different log levels
enum Level { debug, info, warning, error, wtf }

// Define a logDebug function that logs messages at the specified level
void logDebug(String message, {Level level = Level.info}) {
  // Only log messages if app is running in debug mode
  if (kDebugMode) {
    try{
      switch (level) {
        case Level.debug:
          logger.d(message);
          break;
        case Level.info:
          logger.i(message);
          break;
        case Level.warning:
          logger.w(message);
          break;
        case Level.error:
          logger.e(message);
          break;
        case Level.wtf:
          logger.wtf(message);
          break;
      }
    }catch(e){
      print(e);
    }
  }
}


// Define an interceptor that logs the requests and responses
class LoggerInterceptor extends Interceptor {
  // Initialize a logger instance with the specified configuration
  Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 75,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';

    // Log the error request and error message
    logDebug('${options.method} request => $requestPath', level: Level.error);
    logDebug('Error: ${err.error}, Message: ${err.message}', level: Level.debug);

    // Call the super class to continue handling the error
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';

    // Log the request
    logDebug('${options.method} request => $requestPath', level: Level.info);

    // Call the super class to continue handling the request
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    // Log the response status code and data
    logDebug('StatusCode: ${response.statusCode}, Data: ${response.data}', level: Level.debug);

    // Call the super class to continue handling the response
    return super.onResponse(response, handler);
  }
}
