import 'package:flutter/material.dart';
import 'package:ninja_connect/src/features/start_up/models/onboarding_model.dart';
import 'package:ninja_connect/src/widgets/spacing.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnbaordingTile extends StatelessWidget {
  final OnboardingModel onboardingItem;

  const OnbaordingTile({
    required this.onboardingItem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          onboardingItem.imageUrl,
          width: 250,
          height: 250,
        ),
        // Image.asset(
        //   onboardingItem.imageUrl,
        //   width: 250,
        //   height: 250,
        // ),
        const Spacing.mediumHeight(),
        Text(
          onboardingItem.title,
          style: textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
        const Spacing.mediumHeight(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            onboardingItem.desc,
            textAlign: TextAlign.center,
            style: textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
