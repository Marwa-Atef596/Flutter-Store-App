import 'package:flutter_store_app/core/networking/api_error_handler.dart';
import 'package:flutter_store_app/core/networking/api_result.dart';
import 'package:flutter_store_app/core/networking/api_services.dart';
import 'package:flutter_store_app/features/sign%20up/data/model/sign_up_request_body.dart';
import 'package:flutter_store_app/features/sign%20up/data/model/sign_up_response.dart';

class SignupRepo {
  final ApiServices _apiServices;

  SignupRepo(this._apiServices);

  Future<ApiResult<SignUpResponse>> signUp(
      SignUpRequestBody signUpRequestBody) async {
    try {
      final response = await _apiServices.signUp(signUpRequestBody);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
