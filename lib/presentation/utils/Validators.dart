class Validators {
  static final RegExp nameRegExp = RegExp('[a-zA-Z]'); 
  static final RegExp numberRegExp = RegExp(r'\d');
  static final RegExp phoneNumberRegExp = RegExp(r'^\d{10}$');
  static final RegExp passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

  // Name validator
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required.';
    }

    if (nameRegExp.hasMatch(value)) {
      return 'Enter a valid name';
    }

    return null;
  }

  // Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters, with uppercase, lowercase, numbers, and special characters';
    }

    return null;
  }

  // Phone Number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required';
    }

    if (phoneNumberRegExp.hasMatch(value)) {
      return 'Must be 10 digits';
    }

    return null;
  }
}