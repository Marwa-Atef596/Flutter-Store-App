import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/features/home/ui/widgets/category_list_view.dart';
import 'package:flutter_store_app/features/home/ui/widgets/custom_app_bar.dart';
import 'package:flutter_store_app/features/home/ui/widgets/custom_search_text.dart';
import 'package:flutter_store_app/features/home/ui/widgets/product_grid_view.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(title: 'Discover'),
                  CustomSearchText(),
                  verticalSpace(30),
                  CategoryListView(),
                  verticalSpace(10),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            sliver: ProductGridView(),
          ),
        ],
      ),
    );
  }
}
