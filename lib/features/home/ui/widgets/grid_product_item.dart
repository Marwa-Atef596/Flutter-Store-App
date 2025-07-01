import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_cubit.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_state.dart';
import 'package:flutter_store_app/features/product_details/ui/product_details_screen.dart';

class GridProductItem extends StatelessWidget {
  const GridProductItem({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailsScreen(productModel: productModel),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            verticalSpace(10),
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Image.network(
                productModel.image,
                height: 150.h,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.title,
                    style: AppStyles.font16DarkSemiBold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(4),
                  Text(
                    '\$${productModel.price}',
                    style: AppStyles.font14GrayRegular,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final isFav = context.read<HomeCubit>().isFavorite(productModel.id);
          return Positioned(
            right: 12.w,
            top: 12.h,
            child: GestureDetector(
              onTap: () {
                context.read<HomeCubit>().addFavorite(productModel);
              },
              child: Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: AppColors.mainDark.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  size: 24.sp,
                  color: isFav ? Colors.red : AppColors.mainDark,
                ),
              ),
            ),
          );
        },
      ),
    ]);
  }
}
