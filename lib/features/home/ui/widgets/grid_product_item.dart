import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';

class GridProductItem extends StatelessWidget {
  const GridProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz4qXgessu_kcCtS_JNhVANnQeyhxjpNoqWw&s',
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'title',
                  style: AppStyles.font16DarkSemiBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(4),
                Text(
                  'price',
                  style: AppStyles.font14GrayRegular,
                ),
              ],
            ),
          ),
        ],
      ),
      Positioned(
        right: 8.w,
        top: 8.h,
        child: Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: AppColors.mainDark.withValues(alpha: .09),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.favorite_border,
            size: 20.sp,
            color: AppColors.mainDark,
          ),
        ),
      ),
    ]);
  }
}
