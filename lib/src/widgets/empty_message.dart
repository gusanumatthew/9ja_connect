import 'package:flutter/material.dart';
import 'package:ninja_connect/src/core/constants/images.dart';
import 'package:ninja_connect/src/widgets/spacing.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const Spacer(),
        Image.asset(AppImages.empty),
        Text(
          text,
          style: textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 4),
      ],
    );
  }
}

class ErrorList extends StatelessWidget {
  const ErrorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Expanded(child: Image.asset(AppImages.error)),
        Text(
          'Something went wrong!',
          style: textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
        const Spacing.tinyHeight(),
        Text(
          'Can\t load items right now',
          style: textTheme.subtitle2,
        ),
        const Spacing.largeHeight(),
      ],
    );
  }
}
