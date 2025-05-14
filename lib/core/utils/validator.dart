import 'package:intl/intl.dart';

class UtilValidators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^.{4,10}$',
  );

  static final RegExp _phoneNumberRegExp =
      RegExp(r'^(03|05|07|08|09|01[2|6|8|9])+([0-9]{8})$');

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isVietnamesePhoneNumber(String phoneNumber) {
    return _phoneNumberRegExp.hasMatch(phoneNumber);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isValidName(String name) {
    return name.isNotEmpty;
  }

  static isValidString(String name) {
    return name.isNotEmpty;
  }

  static isValidNumeric(String input) {
    return input.isNotEmpty && RegExp(r'^[0-9]+$').hasMatch(input);
  }

  ///Singleton factory
  static final UtilValidators _instance = UtilValidators._internal();

  factory UtilValidators() {
    return _instance;
  }

  UtilValidators._internal();

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter Email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value.trim()) ? null : 'Invalid email format';
  }

  static String? validatePAN(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter PAN';
    final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    return panRegex.hasMatch(value.trim())
        ? null
        : 'Invalid PAN format (ABCDE1234F)';
  }

  static String? validateAadhaar(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter Aadhaar Number';
    }
    final aadhaarRegex = RegExp(r'^\d{12}$');
    return aadhaarRegex.hasMatch(value.trim())
        ? null
        : 'Aadhaar must be 12 digits';
  }

  static String? validateDOB(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter Date of Birth';
    }
    try {
      final date = DateFormat('dd/MM/yyyy').parseStrict(value.trim());
      if (date.isAfter(DateTime.now())) return 'DOB cannot be in the future';
      return null;
    } catch (_) {
      return 'Invalid date format (DD/MM/YYYY)';
    }
  }

  /// Validates if the provided string is a valid 6-digit Indian PIN code
  static bool isValidIndianPinCode(String pinCode) {
    return RegExp(r'^[1-9][0-9]{5}$').hasMatch(pinCode);
  }
}
