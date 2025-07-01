// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/core/di/dependency_injection.dart';
import 'package:flutter_store_app/core/routing/routes.dart';
import 'package:flutter_store_app/features/category/logic/cubit/category_cubit.dart';
import 'package:flutter_store_app/features/category/ui/widgets/product_category.dart';
import 'package:flutter_store_app/features/home/ui/home_screen.dart';
import 'package:flutter_store_app/features/login/logic/cubit/login_cubit.dart';
import 'package:flutter_store_app/features/login/ui/login_screen.dart';
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
          builder: (_) => HomeScreen(),
        );
      case Routes.productCategory:
        final category = arguments as String;

        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<CategoryCubit>()..fetchProductsByCategory(category),
            child: ProductCategory(
              categoryName: category,
            ),
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
