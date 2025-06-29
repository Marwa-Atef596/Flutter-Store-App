import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/core/helper/extentions.dart';
import 'package:flutter_store_app/core/routing/routes.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account?',
            style: AppStyles.font14DarkRegular,
          ),
          TextSpan(
            text: ' Login',
            style: AppStyles.font14DarkSemiBold,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushReplacementNamed(Routes.loginScreen);
              },
          ),
        ],
      ),
    );
  }
}