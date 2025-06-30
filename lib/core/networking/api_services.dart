import 'package:dio/dio.dart';
import 'package:flutter_store_app/core/networking/api_constans.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';
import 'package:flutter_store_app/features/login/data/model/login_request_body.dart';
import 'package:flutter_store_app/features/login/data/model/login_response.dart';
import 'package:flutter_store_app/features/sign%20up/data/model/sign_up_request_body.dart';
import 'package:flutter_store_app/features/sign%20up/data/model/sign_up_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(ApiConstants.signUp)
  Future<SignUpResponse> signUp(
    @Body() SignUpRequestBody signUpRequestBody,
  );

  @GET(ApiConstants.homeProduct)
  Future<List<ProductModel>> getAllProducts();
}
