import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioProvider {
  DioProvider._(); // Private constructor for singleton pattern

  static Dio? _dio; // Make it private to enforce encapsulation

  static final Duration _timeout = const Duration(seconds: 30);

  /// Returns a configured Dio instance
  static Dio getInstance() {
    _dio ??= Dio()
      ..options = BaseOptions(
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        responseType: ResponseType.json,
      )
      ..interceptors.add(_logger);

    return _dio!;
  }

  /// PrettyDioLogger instance
  static PrettyDioLogger get _logger => PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
      );

  /// Optional: Add/Update headers dynamically
  static void setHeaders(Map<String, String> headers) {
    _dio?.options.headers.addAll(headers);
  }

  /// Optional: Clear headers and reset to default
  static void resetHeaders() {
    _dio?.options.headers.clear();
    _dio?.options.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
  }
}
