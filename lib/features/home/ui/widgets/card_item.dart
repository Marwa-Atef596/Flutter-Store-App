import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';
import 'package:flutter_store_app/features/home/ui/widgets/grid_product_item.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: GridProductItem(productModel: productModel),
    );
  }
}
