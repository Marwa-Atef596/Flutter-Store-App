import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/core/helper/password_validation.dart';
import 'package:flutter_store_app/core/helper/spacing.dart';
import 'package:flutter_store_app/core/widgets/app_text_form_field.dart';
import 'package:flutter_store_app/features/login/logic/cubit/login_cubit.dart';

class NameAndPassword extends StatefulWidget {
  const NameAndPassword({super.key});

  @override
  State<NameAndPassword> createState() => _NameAndPasswordState();
}

class _NameAndPasswordState extends State<NameAndPassword> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Enter your name',
            text: 'Name',
            controller: context.read<LoginCubit>().nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid name';
              }
            },
          ),
          verticalSpace(20),
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
            controller: context.read<LoginCubit>().passwordController,
            validator: validatePassword,
          ),
        ],
      ),
    );
  }
}
