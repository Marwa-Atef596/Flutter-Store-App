// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/core/di/dependency_injection.dart';
import 'package:flutter_store_app/core/routing/routes.dart';
import 'package:flutter_store_app/features/home/ui/home_screen.dart';
import 'package:flutter_store_app/features/login/logic/cubit/login_cubit.dart';
import 'package:flutter_store_app/features/login/ui/login_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: LoginScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
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
