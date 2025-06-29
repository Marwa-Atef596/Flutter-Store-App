// ignore_for_file: unreachable_switch_default

import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      apiErrorModel = _handleDioError(error);
    } else {
      apiErrorModel = ApiErrorModel(message: "An unexpected error occurred");
    }
  }
}

ApiErrorModel _handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return ApiErrorModel(message: "Connection timed out");

    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        return ApiErrorModel.fromJson(data);
      } else {
        return ApiErrorModel(
          message: data?.toString() ?? "Something went wrong",
        );
      }

    case DioExceptionType.cancel:
      return ApiErrorModel(message: "Request cancelled");

    case DioExceptionType.connectionError:
    case DioExceptionType.badCertificate:
      return ApiErrorModel(message: "No internet connection");

    default:
      return ApiErrorModel(message: "Unknown Dio error occurred");
  }
}
