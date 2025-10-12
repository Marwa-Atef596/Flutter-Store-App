// ignore_for_file: depend_on_referenced_packages, unused_element

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';
import 'package:flutter_store_app/features/home/data/model/rating_model.dart';
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
  late List<ProductModel> cartList = [];
  final Map<int, int> cartQuantities = {};

  void emitHomeState() async {
    emit(HomeState.loading());

    final response = await _homeProductRepo.getAllProducts();

    response.when(success: (data) async {
      _allFetshedProducts = data;
      productList = List.from(data);
      await loadFavoritesFromPrefs();
      await loadCartFromPrefs();

      emit(HomeState.success(productList));
    }, failure: (error) {
      emit(HomeState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  void searchProduct(String query) {
    if (query.trim().isEmpty) {
      productList = List.from(_allFetshedProducts);
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
    emit(HomeState.success(List.from(productList)));
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

  void addToCart(ProductModel product) {
    debugPrint("Adding to cart: ${product.title}");

    final existing = cartList.firstWhere(
      (item) => item.id == product.id,
      orElse: () => ProductModel(
        id: -1,
        title: '',
        price: 0,
        image: '',
        description: '',
        category: '',
        rating: RatingModel(rate: 0, count: 0),
      ),
    );

    if (existing.id != -1) {
      cartQuantities[product.id] = (cartQuantities[product.id] ?? 1) + 1;
    } else {
      cartList.add(product);
      cartQuantities[product.id] = 1;
    }
    saveCartToPrefs();
    emit(HomeState.cartUpdated(
      cartItems: List.from(cartList),
      cartQuantities: Map.from(cartQuantities),
    ));
  }

  void removeFromCart(int productId) {
    cartList.removeWhere((item) => item.id == productId);
    cartQuantities.remove(productId);
    saveCartToPrefs();
    emit(HomeState.cartUpdated(
      cartItems: List.from(cartList),
      cartQuantities: Map.from(cartQuantities),
    ));
  }

  int getProductQuantity(int productId) {
    return cartQuantities[productId] ?? 1;
  }

  void increaseQuantity(int productId) {
    if (cartQuantities.containsKey(productId)) {
      cartQuantities[productId] = cartQuantities[productId]! + 1;
      saveCartToPrefs();
      emit(HomeState.cartUpdated(
        cartItems: List.from(cartList),
        cartQuantities: Map.from(cartQuantities),
      ));
    }
  }

  void decreaseQuantity(int productId) {
    if (cartQuantities.containsKey(productId)) {
      if (cartQuantities[productId]! > 1) {
        cartQuantities[productId] = cartQuantities[productId]! - 1;
      } else {
        removeFromCart(productId);
        return;
      }
      saveCartToPrefs();
      emit(HomeState.cartUpdated(
        cartItems: List.from(cartList),
        cartQuantities: Map.from(cartQuantities),
      ));
    }
  }

  double get totalCartPrice {
    double total = 0;
    for (var item in cartList) {
      final quantity = cartQuantities[item.id] ?? 1;
      total += (item.price ?? 0) * quantity;
    }
    return total;
  }

  Future<void> saveCartToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJsonString =
          jsonEncode(cartList.map((e) => e.toJson()).toList());
      final cartQuantitiesJson = jsonEncode(
        cartQuantities.map((key, value) => MapEntry(key.toString(), value)),
      );

      await prefs.setString('cart_items', cartJsonString);
      await prefs.setString('cart_quantities', cartQuantitiesJson);
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  Future<void> loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final cartJsonString = prefs.getString('cart_items');
    final cartQuantitiesJson = prefs.getString('cart_quantities');

    if (cartJsonString != null && cartQuantitiesJson != null) {
      final cartListDecoded = jsonDecode(cartJsonString) as List<dynamic>;

      cartList = cartListDecoded
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();

      final decodedQuantities =
          jsonDecode(cartQuantitiesJson) as Map<String, dynamic>;

      cartQuantities.clear();
      decodedQuantities.forEach((key, value) {
        cartQuantities[int.parse(key)] = value as int;
      });

      emit(HomeState.cartUpdated(
        cartItems: List.from(cartList),
        cartQuantities: Map.from(cartQuantities),
      ));
    }
  }

  void clearCart() async {
    cartList.clear();
    cartQuantities.clear();

    // مسح من SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart_items');
    await prefs.remove('cart_quantities');

    emit(HomeState.cartUpdated(
      cartItems: List.from(cartList),
      cartQuantities: Map.from(cartQuantities),
    ));
  }
}
