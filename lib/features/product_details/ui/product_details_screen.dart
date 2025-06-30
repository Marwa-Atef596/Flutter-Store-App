import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';
import 'package:flutter_store_app/features/home/ui/widgets/custom_app_bar.dart';
import 'package:flutter_store_app/features/product_details/ui/widgets/price_and_button_cart_details.dart';
import 'package:flutter_store_app/features/product_details/ui/widgets/rate_and_count_details.dart';
import 'package:flutter_store_app/features/product_details/ui/widgets/rating_bar_details.dart';
import 'package:flutter_store_app/features/product_details/ui/widgets/title_and_fav_details.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PriceAndButtonCartDetails(
        productModel: productModel,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(
                title: 'Details',
                centerTitle: true,
                showBack: true,
              ),
              verticalSpace(20),
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                child: Image.network(
                  productModel.image,
                  height: 300.h,
                  fit: BoxFit.contain,
                ),
              ),
              verticalSpace(40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleAndFavDetails(
                      productModel: productModel,
                    ),
                    verticalSpace(20),
                    RateAndCountDetails(
                      productModel: productModel,
                    ),
                    verticalSpace(20),
                    Align(
                        alignment: Alignment.center, child: RatingBarDetails()),
                    verticalSpace(20),
                    Text(
                      productModel.description,
                      style: AppStyles.font16GrayRegular,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
