// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/routing/routes.dart';
import 'package:flutter_store_app/core/helper/extentions.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';
import 'package:flutter_store_app/features/favorite_items/ui/favorite_screen.dart';
import 'package:flutter_store_app/features/home/ui/widgets/custom_app_bar.dart';
import 'package:flutter_store_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:flutter_store_app/features/profile/logic/cubit/profile_state.dart';
import 'package:flutter_store_app/features/profile/ui/widgets/profile_text_row.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (prev, curr) => curr.isLoggedOut,
      listener: (context, state) {
        if (state.isLoggedOut) {
          context.pushReplacementNamed(Routes.loginScreen);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    title: 'Account',
                    centerTitle: true,
                    showBack: true,
                  ),
                  verticalSpace(10),
                  Card(
                    color: AppColors.white,
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.mainDark,
                        child: const Icon(Icons.person,
                            size: 30, color: Colors.white),
                      ),
                      title: Text('Name: ${state.name}',
                          style: AppStyles.font18DarkMedium),
                      subtitle: Text('Email: ${state.email}',
                          style: AppStyles.font16DarkMedium),
                    ),
                  ),
                  Divider(
                    color: AppColors.gray,
                    thickness: 0.5,
                  ),
                  verticalSpace(40),
                  ProfileTextRow(
                    text: 'Saved',
                    iconData: Icons.favorite_border_outlined,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteScreen(),
                      ),
                    ),
                  ),
                  verticalSpace(30),
                  ProfileTextRow(
                    text: 'My Cart',
                    iconData: Icons.shopping_cart_outlined,
                    onTap: () => context.pushNamed(Routes.cartScreen),
                  ),
                  verticalSpace(30),
                  ProfileTextRow(
                    text: 'Logout',
                    iconData: Icons.logout_outlined,
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirm Logout'),
                          content:
                              const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: AppColors.mainDark),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Logout',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        context.read<ProfileCubit>().logout();
                      }
                    },
                  ),

                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton.icon(
                  //     onPressed: () {
                  //       context.read<ProfileCubit>().logout();
                  //     },
                  //     icon: const Icon(Icons.logout),
                  //     label: const Text('Logout'),
                  //     style:
                  //         ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  //   ),
                  // ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
