import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/extentions.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/routing/routes.dart';
import 'package:flutter_store_app/features/category/logic/cubit/category_cubit.dart';
import 'package:flutter_store_app/features/category/logic/cubit/category_state.dart';
import 'package:flutter_store_app/features/category/ui/widgets/category_list.dart';
import 'package:flutter_store_app/features/home/ui/widgets/custom_app_bar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        child: Column(
          children: [
            CustomAppBar(
              title: 'Category',
              showBack: true,
              centerTitle: true,
            ),
            verticalSpace(10),
            Expanded(
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    categoriesNameLoaded: (categories) {
                      final images = context.read<CategoryCubit>().images;

                      return ListView.separated(
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => verticalSpace(20),
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              final selectedCategory = categories[index];
                              context.pushNamed(
                                Routes.productCategory,
                                arguments: selectedCategory,
                              );
                            },
                            child: CategoryList(
                              imageUrl: images[index % images.length],
                              categoryName: categories[index],
                            ),
                          );
                        },
                      );
                    },
                    productsCategoryLoaded: (_) => const SizedBox(),
                    error: (msg) => Center(child: Text('Error: $msg')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
