import 'package:flutter/material.dart';

extension ValidationExtension on BuildContext {
  String? validateFieldNotEmpty(String? value, BuildContext context) =>
      value == null || value.isEmpty ? "Field cannot be empty" : null;

  String? validateFieldNotNull<T>(T? value, BuildContext context) =>
      value == null ? 'Field cannot be empty' : null;

  String? validateFullName<T>(String? value, BuildContext context) {
    if (value == null) return "Field cannot be empty";

    if (value.isEmpty) return "Field cannot be empty";

    if (value.split(' ').length < 2) {
      return "Please enter your full name";
    }
    return null;
  }

  String? validateEmailAddress(String? value, BuildContext context) {
    if (value == null) return "Field cannot be empty";

    if (value.isEmpty) return "Field cannot be empty";

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    return !emailValid ? "Enter a valid email address" : null;
  }

  String? validatePassword(String? value, BuildContext context) =>
      value == null || value.length < 6
          ? "Password must have 6 or more characters"
          : null;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
