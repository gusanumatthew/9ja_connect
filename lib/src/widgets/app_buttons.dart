import 'package:flutter/material.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final bool isLoading;

  const AppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(46),
          ),
          padding: const EdgeInsets.all(16),
          primary: AppColors.lightBlue,
          onPrimary: AppColors.light,
        ),
        child: isLoading
            ? const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  color: AppColors.deep,
                  strokeWidth: 2,
                ),
              )
            : Text(label),
      ),
    );
  }
}
