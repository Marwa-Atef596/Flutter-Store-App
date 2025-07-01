import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_cubit.dart';
import 'package:flutter_store_app/features/home/logic/cubit/home_state.dart';
import 'package:flutter_store_app/features/home/ui/widgets/card_item.dart';
import 'package:flutter_store_app/features/home/ui/widgets/custom_app_bar.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            CustomAppBar(
              title: 'Saved Items',
              centerTitle: true,
              showBack: true,
            ),
            verticalSpace(20),
            Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) => current is FavoriteUpdated,
              builder: (context, state) {
                final favorites = context.read<HomeCubit>().favoriteList;
                if (favorites.isEmpty) {
                  return const Center(child: Text('No favorite items yet.'));
                }
                return GridView.builder(
                  itemCount: favorites.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return CardItem(productModel: favorites[index]);
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
