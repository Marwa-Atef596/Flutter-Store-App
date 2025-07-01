import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';

class CategoryList extends StatelessWidget {
  final String imageUrl;
  final String categoryName;

  const CategoryList({
    super.key,
    required this.imageUrl,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: AppColors.mainDark.withValues(alpha: .2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withValues(alpha: .25),
            blurRadius: 6,
            spreadRadius: 3,
            offset: const Offset(4, 4),
          )
        ],
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.contain,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.mainDark.withValues(alpha: .15),
        ),
        child: Center(
          child: Text(
            categoryName.toUpperCase(),
            style: AppStyles.font18whiteBold,
          ),
        ),
      ),
    );
  }
}
