// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_store_app/core/routing/routes.dart';
import 'package:flutter_store_app/features/login/ui/login_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('no routes defiend for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
