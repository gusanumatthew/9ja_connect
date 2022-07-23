import 'package:flutter/material.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    this.labelText,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.controller,
    this.maxLines,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.enabled,
    this.initialValue,
    this.obscureText = false,
    this.textCapitalization,
  }) : super(key: key);

  final String? labelText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? enabled;
  final String? initialValue;
  final TextCapitalization? textCapitalization;

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  final focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      maxLines: widget.maxLines ?? 1,
      validator: widget.validator,
      controller: widget.controller,
      enabled: widget.enabled,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? AppColors.lightBlue : null,
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyText2?.color,
        ),
        contentPadding: const EdgeInsets.all(16),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.lightBlue),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
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
