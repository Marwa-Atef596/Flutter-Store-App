import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/theming/app_styles.dart';
import 'package:flutter_store_app/core/widgets/app_text_button.dart';
import 'package:flutter_store_app/features/login/logic/cubit/login_cubit.dart';
import 'package:flutter_store_app/features/login/ui/widgets/already_have_not_account.dart';
import 'package:flutter_store_app/features/login/ui/widgets/forget_password_text.dart';
import 'package:flutter_store_app/features/login/ui/widgets/login_bloc_listener.dart';
import 'package:flutter_store_app/features/login/ui/widgets/name_and_password.dart';
import 'package:flutter_store_app/features/login/ui/widgets/terms_and_condicions_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  'Login to your account',
                  style: AppStyles.font32DarkSemiBold,
                ),
                verticalSpace(8),
                Text(
                  'It’s great to see you again.',
                  style: AppStyles.font16GrayRegular,
                ),
                verticalSpace(36),
                NameAndPassword(),
                verticalSpace(24),
                ForgetPasswordText(),
                verticalSpace(40),
                AppTextButton(
                  buttonText: 'Login',
                  textStyle: AppStyles.font16WhiteMedium,
                  onPressed: () {
                    validateThenDoLogin(context);
                  },
                ),
                verticalSpace(60),
                Column(
                  children: [
                    TermsAndConditionsText(),
                    verticalSpace(30),
                    AlreadyHaveNotAccountText()
                  ],
                ),
                LoginBlocListener()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().emitLoginState();
    }
  }
}
