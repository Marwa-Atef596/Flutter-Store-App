import 'package:flutter/material.dart';
import 'package:flutter_store_app/core/di/dependency_injection.dart';
import 'package:flutter_store_app/core/helper/check_if_login.dart';
import 'package:flutter_store_app/core/routing/app_router.dart';
import 'package:flutter_store_app/features/payment/networking/payment_api_constants.dart';
import 'package:flutter_store_app/store_app.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  Stripe.publishableKey = PaymentApiConstants.publishablekey;
  WidgetsFlutterBinding.ensureInitialized();

  setupGetit();

  final isLoggedIn = await checkIfLoggedIn();

  runApp(StoreApp(
    appRouter: AppRouter(),
    isLoggedIn: isLoggedIn,
  ));
}
