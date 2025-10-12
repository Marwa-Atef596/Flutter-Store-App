import 'package:dio/dio.dart';
import 'package:flutter_store_app/features/payment/data/model/customer_model/customer_model.dart';
import 'package:flutter_store_app/features/payment/data/model/ephmeral_key_model/ephmeral_key_model.dart';
import 'package:flutter_store_app/features/payment/data/model/init_payment_sheet_model.dart';
import 'package:flutter_store_app/features/payment/data/model/payment_intent_input_model.dart';
import 'package:flutter_store_app/features/payment/data/model/payment_intent_model/payment_intent_model.dart';
import 'package:flutter_store_app/features/payment/networking/payment_api_constants.dart';
import 'package:flutter_store_app/features/payment/networking/payment_api_services.dart';
import 'package:flutter_store_app/features/sign%20up/data/model/sign_up_request_body.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StripeServices {
  final PaymentApiServices paymentApiServices = PaymentApiServices();

  Future<PaymentIntentModel> createPatmentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await paymentApiServices.post(
      body: paymentIntentInputModel.toJson(),
      url: PaymentApiConstants.paymentIntentUrl,
      token: PaymentApiConstants.secretkey,
      contentType: Headers.formUrlEncodedContentType,
    );
    return PaymentIntentModel.fromJson(response.data);
  }

  Future<EphmeralKeyModel> createEphmeralKey(
      {required String customerId}) async {
    var response = await paymentApiServices.post(
      body: {'customer': customerId},
      url: PaymentApiConstants.ephemeralkeysUrl,
      token: PaymentApiConstants.secretkey,
      contentType: Headers.formUrlEncodedContentType,
      headers: {
        'Authorization': "Bearer ${PaymentApiConstants.secretkey}",
        'Stripe-Version': '2025-07-30.basil',
      },
    );
    return EphmeralKeyModel.fromJson(response.data);
  }

  Future<void> initPaymentSheet({
    SignUpRequestBody? signUpRequestBody,
    required InitPaymentSheetInputModel initPaymentSheetInputModel,
  }) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      merchantDisplayName: signUpRequestBody?.userName ?? 'Store App',
      paymentIntentClientSecret: initPaymentSheetInputModel.clientSecret,
      customerEphemeralKeySecret: initPaymentSheetInputModel.ephemeralKeySecret,
      customerId: initPaymentSheetInputModel.customerId,
    ));
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    String customerId = paymentIntentInputModel.customerId;

    final prefs = await SharedPreferences.getInstance();

    // نحاول نجيب Stripe customer ID من SharedPreferences
    if (customerId.isEmpty) {
      customerId = prefs.getString('stripe_customer_id') ?? '';

      //  لو لسه مش موجود، نعمل Customer جديد ونحفظه
      if (customerId.isEmpty) {
        final newCustomer = await createCustomer();
        customerId = newCustomer.id ?? '';
        await prefs.setString('stripe_customer_id', customerId);
      }
    }

    // نحدث customerId داخل الموديل
    final updatedModel = PaymentIntentInputModel(
      amount: paymentIntentInputModel.amount,
      currency: paymentIntentInputModel.currency,
      customerId: customerId,
    );

    // نكمل العمليات ببيانات صحيحة
    final paymentIntentModel = await createPatmentIntent(updatedModel);
    final ephemeralKeyModel = await createEphmeralKey(customerId: customerId);

    final initPaymentSheetInputModel = InitPaymentSheetInputModel(
      clientSecret: paymentIntentModel.clientSecret!,
      customerId: customerId,
      ephemeralKeySecret: ephemeralKeyModel.secret!,
    );

    await initPaymentSheet(
        initPaymentSheetInputModel: initPaymentSheetInputModel);
    await displayPaymentSheet();
  }

  Future<CustomerModel> createCustomer() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userName = prefs.getString('user_name') ?? 'Store User';
      final email = prefs.getString('user_email') ?? 'user@example.com';

      var response = await paymentApiServices.post(
        body: {
          'name': userName,
          'email': email,
        },
        url: PaymentApiConstants.createCustomer,
        token: PaymentApiConstants.secretkey,
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'Authorization': "Bearer ${PaymentApiConstants.secretkey}",
        },
      );

      final customer = CustomerModel.fromJson(response.data);
      return customer;
    } catch (e) {
      throw Exception('Failed to create Stripe customer: $e');
    }
  }
}
