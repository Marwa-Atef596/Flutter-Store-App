import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';
import 'package:flutter_store_app/core/widgets/app_text_button.dart';
import 'package:flutter_store_app/features/login/ui/widgets/terms_and_condicions_text.dart';
import 'package:flutter_store_app/features/sign%20up/logic/cubit/sign_up_cubit.dart';
import 'package:flutter_store_app/features/sign%20up/ui/widgets/already_have_account.dart';
import 'package:flutter_store_app/features/sign%20up/ui/widgets/signup_bloc_listener.dart';
import 'package:flutter_store_app/features/sign%20up/ui/widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 30.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create an account',
                  style: AppStyles.font32DarkSemiBold,
                ),
                verticalSpace(8),
                Text(
                  'Let’s create your account.',
                  style: AppStyles.font16GrayRegular,
                ),
                verticalSpace(36),
                SignupForm(),
                verticalSpace(60),
                AppTextButton(
                  buttonText: 'Create an Account',
                  textStyle: AppStyles.font16WhiteMedium,
                  onPressed: () {
                    validateThenDoLogin(context);
                  },
                ),
                verticalSpace(50),
                Column(
                  children: [
                    TermsAndConditionsText(),
                    verticalSpace(30),
                    AlreadyHaveAccountText()
                  ],
                ),
                SignupBlocListener()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (context.read<SignUpCubit>().formKey.currentState!.validate()) {
      context.read<SignUpCubit>().emitSignUpState();
    }
  }
}
