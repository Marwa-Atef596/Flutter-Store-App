import 'package:flutter/material.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'By logging, you agree to our',
            style: AppStyles.font14GrayRegular,
          ),
          TextSpan(
            text: ' Terms & Conditions',
            style: AppStyles.font14DarkRegular,
          ),
          TextSpan(
            text: ' and',
            style: AppStyles.font14GrayRegular.copyWith(height: 1.5),
          ),
          TextSpan(
            text: ' Privacy Policy',
            style: AppStyles.font14DarkRegular,
          ),
        ],
      ),
    );
  }
}
