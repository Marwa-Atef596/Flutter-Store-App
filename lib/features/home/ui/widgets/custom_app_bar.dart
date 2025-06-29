import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/extentions.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool? centerTitle;
  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: centerTitle,
        titleTextStyle: TextStyle(letterSpacing: .0),
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: showBack
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.mainDark,
                  size: 30.sp,
                ),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text(
          title,
          style: showBack
              ? AppStyles.font24DarkSemiBold
              : AppStyles.font32DarkSemiBold,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.mainDark,
              size: 30.sp,
            ),
          ),
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
