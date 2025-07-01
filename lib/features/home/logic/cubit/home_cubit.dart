// ignore_for_file: depend_on_referenced_packages, unused_element

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';
import 'package:flutter_store_app/features/home/data/repos/home_product_repo.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeProductRepo _homeProductRepo;

  HomeCubit(this._homeProductRepo) : super(HomeState.initial());

  TextEditingController searchText = TextEditingController();

  late List<ProductModel> _allFetshedProducts = [];
  late List<ProductModel> productList = [];
  late List<ProductModel> favoriteList = [];

  void emitHomeState() async {
    emit(HomeState.loading());

    final response = await _homeProductRepo.getAllProducts();

    response.when(success: (data) async {
      _allFetshedProducts = data;
      productList = List.from(data);
      await loadFavoritesFromPrefs();
      emit(HomeState.success(productList));
    }, failure: (error) {
      emit(HomeState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  void searchProduct(String query) {
    if (query.trim().isEmpty) {
      productList = List.from(_allFetshedProducts); // show all
    } else {
      productList = _allFetshedProducts.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    emit(HomeState.success(productList));
  }

  void filterByCategory(String category) {
    if (category.toLowerCase() == 'all') {
      productList = List.from(_allFetshedProducts);
    } else {
      productList = _allFetshedProducts
          .where((product) =>
              product.category.toLowerCase() == category.toLowerCase())
          .toList();
    }
    emit(HomeState.success(productList));
  }

  Future<void> addFavorite(ProductModel product) async {
    final isFav = favoriteList.any((e) => e.id == product.id);
    if (isFav) {
      favoriteList.removeWhere((e) => e.id == product.id);
    } else {
      final freshProduct = _allFetshedProducts.firstWhere(
        (element) => element.id == product.id,
        orElse: () => product,
      );
      favoriteList.add(freshProduct);
    }
    await _saveFavoritesToPrefs();
    emit(HomeState.favoriteUpdated(List.from(favoriteList)));
  }

  bool isFavorite(int productId) {
    return favoriteList.any((element) => element.id == productId);
  }

  Future<void> _saveFavoritesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final favJsonList =
        favoriteList.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('favorites', favJsonList);
  }

  Future<void> loadFavoritesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final favJsonList = prefs.getStringList('favorites');
    if (favJsonList != null) {
      favoriteList = favJsonList
          .map((json) => ProductModel.fromJson(jsonDecode(json)))
          .toList();
      emit(HomeState.favoriteUpdated(List.from(favoriteList)));
    }
  }
}
