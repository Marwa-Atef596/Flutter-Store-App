import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/features/home/ui/widgets/grid_product_item.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      padding: EdgeInsets.only(top: 20.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color: Colors.black.withValues(alpha: .2),
                style: BorderStyle.solid),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                spreadRadius: 3,
                offset: Offset(4, 0),
              )
            ],
          ),
          child: GridProductItem(),
        );
      },
    );
  }
}
