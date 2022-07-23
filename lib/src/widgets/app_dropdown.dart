import 'package:flutter/material.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    Key? key,
    required this.items,
    this.value,
    required this.hintText,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  final List<T> items;
  final T? value;
  final void Function(T?)? onChanged;
  final String hintText;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      onChanged: onChanged,
      value: value,
      validator: validator,
      items: items
          .map(
            (level) => DropdownMenuItem<T>(
              value: level,
              child: Text(level.toString().split(".")[1]),
            ),
          )
          .toList(),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(16),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.lightBlue),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade900),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade900),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
