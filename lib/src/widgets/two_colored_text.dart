import 'package:flutter/material.dart';

class TwoColoredText extends StatelessWidget {
  const TwoColoredText({
    Key? key,
    required this.first,
    required this.second,
    this.fontSize,
  }) : super(key: key);

  final String first;
  final String second;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          first,
          style: textTheme.headline6?.copyWith(
            fontSize: fontSize,
          ),
        ),
        Text(
          second,
          style: textTheme.overline?.copyWith(
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
