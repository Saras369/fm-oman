part of '../data_type_extensions.dart';

extension StringExtensions on String {
  bool parseToBool() {
    final str = this;
    return str.toLowerCase() == 'true';
  }

  ValidX validateMobileNumber() {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);

    if (isEmpty) {
      return ValidX.isNotValid(error: 'Please enter mobile number');
    } else if (!regExp.hasMatch(this)) {
      return ValidX.isNotValid(error: 'Please enter valid mobile number');
    }

    return ValidX.isValid();
  }

  ValidX validateIndianMobileNumber() {
    String pattern = r'^[6-9]\d{9}$';
    RegExp regExp = RegExp(pattern);

    if (isEmpty) {
      return ValidX.isNotValid(error: 'Please enter mobile number');
    } else if (!regExp.hasMatch(this)) {
      return ValidX.isNotValid(error: 'Please enter valid mobile number');
    }

    return ValidX.isValid();
  }

  ValidX validateEmailAddress() {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);

    if (isEmpty) {
      return ValidX.isNotValid(error: 'Please enter email address');
    } else if (!regExp.hasMatch(this)) {
      return ValidX.isNotValid(error: 'Please enter valid email address');
    }

    return ValidX.isValid();
  }

  ValidX validatePassword() {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);

    if (isEmpty) {
      return ValidX.isNotValid(error: 'Please enter password');
    } else if (!regExp.hasMatch(this)) {
      String error = '';

      RegExp upperCaseRegExp = RegExp(r'[A-Z]');
      if (!contains(upperCaseRegExp)) {
        error += 'Should contain at least one upper case';
      }

      RegExp lowerCaseRegExp = RegExp(r'[a-z]');
      if (!contains(lowerCaseRegExp)) {
        error += ', Should contain at least one lower case';
      }

      RegExp digitRegExp = RegExp(r'[0-9]');
      if (!contains(digitRegExp)) {
        error += ', Should contain at least one digit';
      }

      RegExp specialCharRegExp = RegExp(r'[!@#\$&*~]');
      if (!contains(specialCharRegExp)) {
        error += ', Should contain at least one Special character';
      }

      if (length < 8) {
        error += ', Must be at least 8 characters in length';
      }

      error += '.';

      return ValidX.isNotValid(error: error);
    }

    return ValidX.isValid();
  }

  Color get toColor {
    final str = this;

    final hash = str.hashCode;

    return hash.toColor;
  }
}
