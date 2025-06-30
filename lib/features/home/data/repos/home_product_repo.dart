import 'package:flutter_store_app/core/networking/api_error_handler.dart';
import 'package:flutter_store_app/core/networking/api_result.dart';
import 'package:flutter_store_app/core/networking/api_services.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';

class HomeProductRepo {
  final ApiServices _apiServices;

  HomeProductRepo(this._apiServices);

  Future<ApiResult<List<ProductModel>>> getAllProducts() async {
    try {
      final response = await _apiServices.getAllProducts();

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error),
      );
    }
  }
}
