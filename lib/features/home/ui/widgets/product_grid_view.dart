import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/extentions.dart';
import 'package:flutter_store_app/core/routing/routes.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_cubit.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_state.dart';
import 'package:flutter_store_app/features/home/ui/widgets/grid_product_item.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.when(
          initial: () => SliverToBoxAdapter(child: SizedBox.shrink()),
          loading: () => SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.mainDark,
              ),
            ),
          ),
          success: (products) => SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.productDetailsScreen,
                        arguments: products[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.mainDark.withValues(alpha: .2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gray.withValues(alpha: .25),
                          blurRadius: 6,
                          spreadRadius: 3,
                          offset: Offset(4, 4),
                        )
                      ],
                    ),
                    child: GridProductItem(productModel: products[index]),
                  ),
                );
              },
              childCount: products.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.8.h,
            ),
          ),
          error: (message) =>
              SliverToBoxAdapter(child: Center(child: Text(message))),
        );
      },
    );
  }
}
