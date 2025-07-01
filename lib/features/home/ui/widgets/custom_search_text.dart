import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/core/widgets/app_text_form_field.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_cubit.dart';

class CustomSearchText extends StatefulWidget {
  const CustomSearchText({
    super.key,
  });

  @override
  State<CustomSearchText> createState() => _CustomSearchTextState();
}

class _CustomSearchTextState extends State<CustomSearchText> {
  bool _showClear = false;
  late TextEditingController searchController;
  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<HomeCubit>();
    searchController = cubit.searchText;

    _listener = () {
      if (!mounted) return; // 👈 Safe check before setState
      setState(() {
        _showClear = searchController.text.isNotEmpty;
      });
    };

    searchController.addListener(_listener);
  }

  @override
  void dispose() {
    searchController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AppTextFormField(
            onChanged: (query) {
              context.read<HomeCubit>().searchProduct(query);
            },
            text: '',
            controller: searchController,
            hintText: 'Search for products...',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a product name';
              }
              return null;
            },
            suffixIcon: _showClear
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      size: 25.sp,
                    ),
                    onPressed: () {
                      searchController.clear();
                      context.read<HomeCubit>().searchProduct('');
                    },
                  )
                : Icon(
                    Icons.search,
                    size: 25.sp,
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
