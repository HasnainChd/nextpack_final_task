class Validator {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter you email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter you password';
    }
    if (value.length < 6) {
      return 'password must be at least 6 character';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'please enter a strong password';
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter you name..';
    } else if (RegExp(r'[0-9]').hasMatch(value)) {
      return 'Please enter a valid name..';
    }
    return null;
  }
}
