// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_store_app/core/helper/extentions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_store_app/core/routing/routes.dart';

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  context.pushNamedAndRemoveUntil(
    Routes.loginScreen,
    predicate: (route) => false,
  );
}
