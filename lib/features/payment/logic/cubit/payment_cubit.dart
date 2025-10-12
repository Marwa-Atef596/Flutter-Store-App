// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_store_app/features/payment/data/repo/payment_repo.dart';

import '../../data/model/payment_intent_input_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.paymentRepo) : super(PaymentInitial());
  final PaymentRepo paymentRepo;

  Future<void> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentLoading());
    try {
      await paymentRepo.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentFailure(errMessage: e.toString()));
    }
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
