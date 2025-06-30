import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';

class RateAndCountDetails extends StatelessWidget {
  const RateAndCountDetails({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.star,
          size: 30.sp,
          color: AppColors.yellow,
        ),
        horizontalSpace(10),
        Text(productModel.rating.rate.toString(),
            style: AppStyles.font16DarkMedium),
        horizontalSpace(10),
        Text(
          '(${productModel.rating.count} Review)',
          style: AppStyles.font16GrayRegular,
        ),
      ],
    );
  }
}
