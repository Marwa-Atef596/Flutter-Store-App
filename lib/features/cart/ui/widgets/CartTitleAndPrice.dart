// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';

class CartTitleAndPrice extends StatelessWidget {
  const CartTitleAndPrice({
    super.key,
    required this.productModel,
    required this.quantity,
  });
  final ProductModel productModel;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final subtotal = (productModel.price ?? 0) * quantity;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(10),
          Text(productModel.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.font16DarkMedium),
          verticalSpace(8),
          Text('\$${subtotal.toStringAsFixed(2)}',
              style: AppStyles.font16GrayRegular),
        ],
      ),
    );
  }
}
