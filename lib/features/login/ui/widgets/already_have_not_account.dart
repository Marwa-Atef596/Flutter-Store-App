import 'package:flutter/material.dart';
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
        ),
      ]),
    );
  }
}
