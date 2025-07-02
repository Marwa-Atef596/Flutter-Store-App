import 'package:flutter/material.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_colors.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';

class ProfileTextRow extends StatelessWidget {
  const ProfileTextRow({
    super.key,
    required this.text,
    this.onTap,
    required this.iconData,
  });
  final String text;
  final void Function()? onTap;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            iconData,
            size: 32,
            color: AppColors.mainDark,
          ),
          horizontalSpace(15),
          Text(
            text,
            style: AppStyles.font24DarkSemiBold,
          )
        ],
      ),
    );
  }
}
