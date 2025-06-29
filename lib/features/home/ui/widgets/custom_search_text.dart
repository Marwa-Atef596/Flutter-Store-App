import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/core/widgets/app_text_form_field.dart';

class CustomSearchText extends StatefulWidget {
  const CustomSearchText({
    super.key,
  });

  @override
  State<CustomSearchText> createState() => _CustomSearchTextState();
}

class _CustomSearchTextState extends State<CustomSearchText> {
  TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AppTextFormField(
            text: '',
            controller: searchText,
            hintText: 'Search for products...',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a product name';
              }
              return null;
            },
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 25.sp,
              ),
            ),
          ),
        ),
        horizontalSpace(10),
        Padding(
          padding: EdgeInsets.only(top: 22.h),
          child: Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: AppColors.mainDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.sort,
              color: AppColors.white,
              size: 30.sp,
            ),
          ),
        ),
      ],
    );
  }
}
