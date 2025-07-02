// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/features/cart/ui/widgets/CartAddAndDelete.dart';
import 'package:flutter_store_app/features/home/data/model/product_model.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_cubit.dart';

class CartRemove extends StatelessWidget {
  const CartRemove({
    super.key,
    required this.item,
  });
  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            context.read<HomeCubit>().removeFromCart(item.id);
          },
        ),
        CartAddAndDelete(productModel: item,),
      ],
    );
  }
}
