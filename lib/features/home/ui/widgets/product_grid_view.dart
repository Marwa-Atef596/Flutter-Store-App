import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_cubit.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_state.dart';
import 'package:flutter_store_app/features/home/ui/widgets/card_item.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.read<HomeCubit>().productList;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.when(
          favoriteUpdated: (favorites) => _buildGrid(products),
          initial: () => SliverToBoxAdapter(child: SizedBox.shrink()),
          loading: () => SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.mainDark,
              ),
            ),
          ),
          success: (products) => _buildGrid(products),
          error: (message) =>
              SliverToBoxAdapter(child: Center(child: Text(message))),
        );
      },
    );
  }

  Widget _buildGrid(List products) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CardItem(
            productModel: products[index],
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
    );
  }
}
