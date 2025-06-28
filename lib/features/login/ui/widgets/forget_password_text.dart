import 'package:flutter/material.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'Forgot your password?',
          style: AppStyles.font14GrayRegular,
        ),
        TextSpan(
          text: ' Reset your password',
          style: AppStyles.font14DarkRegular,
        ),
      ]),
    );
  }
}
