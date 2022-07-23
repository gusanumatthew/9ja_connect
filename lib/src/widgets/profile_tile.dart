import 'package:flutter/material.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';

import 'spacing.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key? key,
    required this.leading,
    required this.title,
    required this.onPressed,
    this.noTrailing = false,
  }) : super(key: key);

  final IconData leading;
  final String title;
  final VoidCallback? onPressed;
  final bool noTrailing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      tileColor: Colors.blueGrey.shade50,
      onTap: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      leading: Icon(leading, color: AppColors.lightBlue),
      title: Text(
        title,
        style: textTheme.headline4,
      ),
      trailing: noTrailing
          ? const Spacing.empty()
          : const Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColors.lightBlue,
            ),
    );
  }
}
