import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/routing/app_router.dart';
import 'package:flutter_store_app/core/routing/routes.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';

class StoreApp extends StatelessWidget {
  const StoreApp({super.key, required this.appRouter, this.isLoggedIn});
  final AppRouter appRouter;
  final bool? isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: AppColors.mainDark,
            scaffoldBackgroundColor: AppColors.white),
        debugShowCheckedModeBanner: false,
        initialRoute:
            isLoggedIn == true ? Routes.homeScreen : Routes.loginScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
