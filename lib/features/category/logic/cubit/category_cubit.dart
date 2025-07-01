import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/features/category/data/repos/category_repo.dart';
import 'package:flutter_store_app/features/category/logic/cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo categoryRepo;

  CategoryCubit(this.categoryRepo) : super(const CategoryState.initial());

  String? selectedCategory;

  List<String> images = [
    "https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg",
    "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
    "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
    "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg",
  ];

  Future<void> fetchCategoriesName() async {
    emit(const CategoryState.loading());
    final response = await categoryRepo.getCategoryNames();

    response.when(
      success: (categories) =>
          emit(CategoryState.categoriesNameLoaded(categories)),
      failure: (error) => emit(
        CategoryState.error(message: error.apiErrorModel.message ?? ''),
      ),
    );
  }

  Future<void> fetchProductsByCategory(String category) async {
    selectedCategory = category;

    emit(const CategoryState.loading());
    final response = await categoryRepo.getProductsByCategory(category);

    response.when(
      success: (data) => emit(
        CategoryState.productsCategoryLoaded(data),
      ),
      failure: (error) => emit(
        CategoryState.error(
          message: error.apiErrorModel.message ?? '',
        ),
      ),
    );
  }
}
