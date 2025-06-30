// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/core/di/dependency_injection.dart';
import 'package:flutter_store_app/core/routing/routes.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_cubit.dart';
import 'package:flutter_store_app/features/home/ui/home_screen.dart';
import 'package:flutter_store_app/features/login/logic/cubit/login_cubit.dart';
import 'package:flutter_store_app/features/login/ui/login_screen.dart';
import 'package:flutter_store_app/features/product_details/ui/product_details_screen.dart';
import 'package:flutter_store_app/features/sign%20up/logic/cubit/sign_up_cubit.dart';
import 'package:flutter_store_app/features/sign%20up/ui/sign_up_screen.dart';

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
      case Routes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: SignUpScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<HomeCubit>()..emitHomeState(),
            child: HomeScreen(),
          ),
        );
      case Routes.productDetailsScreen:
        final product = arguments as ProductModel;

        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(
            productModel: product,
          ),
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
