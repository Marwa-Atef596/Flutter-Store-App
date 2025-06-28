import 'package:flutter/material.dart';
import 'package:flutter_store_app/core/di/dependency_injection.dart';
import 'package:flutter_store_app/core/routing/app_router.dart';
import 'package:flutter_store_app/store_app.dart';

void main() {
  setupGetit();
  runApp(StoreApp(
    appRouter: AppRouter(),
  ));
}
