import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/features/category/logic/cubit/category_cubit.dart';
import 'package:flutter_store_app/features/category/logic/cubit/category_state.dart';
import 'package:flutter_store_app/features/home/ui/widgets/card_item.dart';
import 'package:flutter_store_app/features/home/ui/widgets/custom_app_bar.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({super.key, required this.categoryName});
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        child: Column(
          children: [
            CustomAppBar(
              title: categoryName.toUpperCase(),
              centerTitle: true,
              showBack: true,
            ),
            Expanded(
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox(),
                    loading: () => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainDark,
                      ),
                    ),
                    categoriesNameLoaded: (_) => const SizedBox(),
                    productsCategoryLoaded: (categories) {
                      return GridView.builder(
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          return CardItem(productModel: categories[index]);
                        },
                      );
                    },
                    error: (msg) => Center(child: Text('Error: $msg')),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
