import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/core/helper/extentions.dart';
import 'package:flutter_store_app/core/routing/routes.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';

class AlreadyHaveNotAccountText extends StatelessWidget {
  const AlreadyHaveNotAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'Already haven\'t an account yet?',
          style: AppStyles.font14DarkRegular,
        ),
        TextSpan(
          text: 'Sign Up',
          style: AppStyles.font14DarkSemiBold,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              context.pushReplacementNamed(Routes.signupScreen);
            },
        ),
      ]),
    );
  }
}
