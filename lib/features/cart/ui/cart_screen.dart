import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';
import 'package:flutter_store_app/core/widgets/app_text_button.dart';
import 'package:flutter_store_app/features/cart/ui/widgets/CartListTile.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_cubit.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_state.dart';
import 'package:flutter_store_app/features/home/ui/widgets/custom_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20.h, right: 25.w, left: 25.w),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            final cartItems = cubit.cartList;

            return cartItems.isNotEmpty
                ? AppTextButton(
                    buttonText: 'Go To Checkout',
                    textStyle: AppStyles.font18whiteBold,
                    onPressed: () {},
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        child: Column(
          children: [
            CustomAppBar(
              title: 'My Cart',
              centerTitle: true,
              showBack: true,
            ),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) => current is CartUpdated,
              builder: (context, state) {
                final cubit = context.watch<HomeCubit>();
                final cartItems = cubit.cartList;

                if (cartItems.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'Your cart is empty.',
                        style: AppStyles.font16GrayRegular,
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: cartItems.length,
                          separatorBuilder: (_, __) => verticalSpace(20),
                          itemBuilder: (context, index) {
                            final product = cartItems[index];
                            final quantity =
                                cubit.getProductQuantity(product.id);
                            return CartListTile(
                              quantity: quantity,
                              productModel: product,
                            );
                          },
                        ),
                      ),
                      verticalSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total : ',
                            style: AppStyles.font24DarkSemiBold,
                          ),
                          Text(
                            '\$${cubit.totalCartPrice.toStringAsFixed(2)}',
                            style: AppStyles.font24DarkSemiBold
                                .copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
