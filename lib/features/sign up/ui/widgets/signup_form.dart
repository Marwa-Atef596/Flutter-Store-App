import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/core/helper/email_validation.dart';
import 'package:flutter_store_app/core/helper/password_validation.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/widgets/app_text_form_field.dart';
import 'package:flutter_store_app/features/sign%20up/logic/cubit/sign_up_cubit.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            text: 'Name',
            hintText: 'Enter your Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid name';
              }
            },
            controller: context.read<SignUpCubit>().nameController,
          ),
          verticalSpace(18),
          AppTextFormField(
            text: 'Email',
            hintText: 'Enter your Email',
            validator: validateEmail,
            controller: context.read<SignUpCubit>().emailController,
          ),
          verticalSpace(18),
          AppTextFormField(
            hintText: 'Enter your password',
            text: 'Password',
            isObscureText: isObscure,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              child: Icon(
                isObscure ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            controller: context.read<SignUpCubit>().passwordController,
            validator: validatePassword,
          ),
        ],
      ),
    );
  }
}
