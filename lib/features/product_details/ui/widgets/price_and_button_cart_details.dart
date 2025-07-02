import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';
import 'package:flutter_store_app/core/widgets/app_text_button.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_cubit.dart';

class PriceAndButtonCartDetails extends StatelessWidget {
  const PriceAndButtonCartDetails({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            direction: Axis.vertical,
            children: [
              Text(
                'Price',
                style: AppStyles.font16GrayRegular,
              ),
              Text(
                '\$${productModel.price}',
                style: AppStyles.font16DarkSemiBold,
              ),
            ],
          ),
          horizontalSpace(20),
          Expanded(
            child: AppTextButton(
                buttonText: 'Add to Cart',
                textStyle: AppStyles.font16WhiteMedium,
                onPressed: () {
                  context.read<HomeCubit>().addToCart(productModel);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added to cart')),
                  );
                }),
          )
        ],
      ),
    );
  }
}
