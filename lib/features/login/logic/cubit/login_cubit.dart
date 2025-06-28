// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/features/login/data/model/login_request_body.dart';
import 'package:flutter_store_app/features/login/data/repo/login_repo.dart';
import 'package:flutter_store_app/features/login/logic/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(LoginState.initial());

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginState() async {
    emit(LoginState.loading());

    final response = await _loginRepo.login(LoginRequestBody(
      userName: nameController.text,
      password: passwordController.text,
    ));

    response.when(success: (data) {
      emit(LoginState.success(data));
    }, failure: (error) {
      emit(
        LoginState.error(error: error.apiErrorModel.message ?? ''),
      );
    });
  }
}
