import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_cubit.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  final List<String> categories = [
    'All',
    'Electronics',
    'Jewelery',
    'Men\'s Clothing',
    'Women\'s Clothing',
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              final selectedCategory = categories[index];
              context.read<HomeCubit>().filterByCategory(selectedCategory);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.mainDark : AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.mainDark.withValues(alpha: .3),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: AppStyles.font14DarkSemiBold.copyWith(
                    color: isSelected ? AppColors.white : AppColors.mainDark,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
