import 'package:flutter_store_app/core/networking/api_error_handler.dart';
import 'package:flutter_store_app/core/networking/api_result.dart';
import 'package:flutter_store_app/core/networking/api_services.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';

class CategoryRepo {
  final ApiServices apiServices;

  CategoryRepo(this.apiServices);

  Future<ApiResult<List<String>>> getCategoryNames() async {
    try {
      final resonse = await apiServices.getCategoriesName();
      return ApiResult.success(resonse);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<ProductModel>>> getProductsByCategory(
      String category) async {
    try {
      final resonse = await apiServices.getProductsByCategory(category);
      return ApiResult.success(resonse);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
