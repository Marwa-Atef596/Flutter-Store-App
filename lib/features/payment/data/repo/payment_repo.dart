import 'package:flutter_store_app/features/payment/networking/stripe_services.dart';

import '../model/payment_intent_input_model.dart';

class PaymentRepo {
  final StripeServices stripeServices;

  PaymentRepo(this.stripeServices);

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      var response = await stripeServices.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return response;
    } catch (e) {
      throw Exception('Failed to create Stripe payment: $e');
    }
  }
}
