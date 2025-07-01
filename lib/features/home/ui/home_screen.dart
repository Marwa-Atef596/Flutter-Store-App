import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/core/di/dependency_injection.dart';
import 'package:flutter_store_app/features/category/logic/cubit/category_cubit.dart';
import 'package:flutter_store_app/features/category/ui/category_screen.dart';
import 'package:flutter_store_app/features/home/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter_store_app/features/favorite_items/ui/favorite_screen.dart';
import 'package:flutter_store_app/features/home/ui/widgets/home_screen_body.dart';
import 'package:flutter_store_app/features/home/ui/widgets/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreenBody(),
    FavoriteScreen(),
    BlocProvider.value(
      value: getIt<CategoryCubit>()..fetchCategoriesName(),
      child: CategoryScreen(),
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: CustomBottomNavigation(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            }),
      ),
    );
  }
}
