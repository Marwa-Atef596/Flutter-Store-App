// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/features/home/data/repos/home_product_repo.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeProductRepo _homeProductRepo;

  HomeCubit(this._homeProductRepo) : super(HomeState.initial());

  TextEditingController searchText = TextEditingController();

  void emitHomeState() async {
    emit(HomeState.loading());

    final response = await _homeProductRepo.getAllProducts();

    response.when(success: (data) {
      emit(HomeState.success(data));
    }, failure: (error) {
      emit(
        HomeState.error(error: error.apiErrorModel.message ?? ''),
      );
    });
  }
}
