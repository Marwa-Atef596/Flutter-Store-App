String? validatePassword(String? value) {
  final password = value?.trim() ?? '';

  if (password.isEmpty) {
    return 'Password is required';
  }

  if (password.length < 6) {
    return 'Password must be at least 6 characters long';
  }

  final regex =
      RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');

  if (!regex.hasMatch(password)) {
    return 'Password must include uppercase, lowercase, number, \nand special character';
  }

  return null;
}
