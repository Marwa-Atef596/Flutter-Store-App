import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';

class TitleAndFavDetails extends StatelessWidget {
  const TitleAndFavDetails({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            productModel.title,
            style: AppStyles.font24DarkSemiBold,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.favorite_border,
            size: 30.sp,
            color: AppColors.mainDark,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
