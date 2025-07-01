import 'package:flutter_store_app/features/home/data/model/product_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;
  const factory CategoryState.loading() = Loading;
  const factory CategoryState.categoriesNameLoaded(List<String> categories) = CategoriesNameLoaded;
  const factory CategoryState.productsCategoryLoaded(List<ProductModel> products) = ProductsCategoryLoaded;
  const factory CategoryState.error({required String message}) = Error;
}
