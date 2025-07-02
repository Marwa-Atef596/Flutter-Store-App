// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_cubit.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_state.dart';

class CartAddAndDelete extends StatelessWidget {
  const CartAddAndDelete({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is CartUpdated,
      builder: (context, state) {
        final quantity =
            context.watch<HomeCubit>().getProductQuantity(productModel.id);

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                context.read<HomeCubit>().decreaseQuantity(productModel.id);
              },
            ),
            Text('$quantity', style: AppStyles.font14DarkSemiBold),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                context.read<HomeCubit>().increaseQuantity(productModel.id);
              },
            ),
          ],
        );
      },
    );
  }
}
