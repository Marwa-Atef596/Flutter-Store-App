// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/features/cart/ui/widgets/CartRemove.dart';
import 'package:flutter_store_app/features/cart/ui/widgets/CartTitleAndPrice.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';

class CartListTile extends StatelessWidget {
  const CartListTile({
    super.key,
    required this.productModel,
    required this.quantity,
  });
  final ProductModel productModel;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: 2,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              productModel.image,
              height: 100.h,
              fit: BoxFit.contain,
            ),
          ),
          horizontalSpace(12),
          CartTitleAndPrice(
            quantity: quantity,
            productModel: productModel,
          ),
          CartRemove(
            item: productModel,
          )
        ],
      ),
    );
  }
}
