// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/features/sign%20up/data/model/sign_up_request_body.dart';
import 'package:flutter_store_app/features/sign%20up/data/repos/signup_repo.dart';
import 'package:flutter_store_app/features/sign%20up/logic/cubit/sign_up_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignupRepo _signupRepo;
  SignUpCubit(this._signupRepo) : super(SignUpState.initial());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void emitSignUpState() async {
    emit(SignUpState.loading());

    final response = await _signupRepo.signUp(
      SignUpRequestBody(
        userName: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    response.when(success: (signUpResponse) async {
      debugPrint('Registered user ID: ${signUpResponse.userId}');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', signUpResponse.userId);
      emit(SignUpState.success(signUpResponse));
    }, failure: (error) {
      emit(
        SignUpState.error(error: error.apiErrorModel.message ?? ''),
      );
    });
  }
}
