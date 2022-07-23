import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ninja_connect/src/core/constants/strings.dart';
import 'package:ninja_connect/src/core/routes.dart';
import 'package:ninja_connect/src/widgets/app_buttons.dart';
import 'package:ninja_connect/src/widgets/spacing.dart';
import 'package:ninja_connect/src/widgets/status_bar.dart';
import 'package:ninja_connect/src/widgets/two_colored_text.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Statusbar(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            const Hero(
              tag: "logo",
              child: TwoColoredText(
                first: '9ja',
                second: 'Connect',
                fontSize: 28,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            AppButton(
                label: 'Sign me up',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.register);
                }),
            const Spacing.mediumHeight(),
            Center(
              child: Text.rich(
                TextSpan(
                  text: AppStrings.alreadyAccount,
                  style: textTheme.bodyText1,
                  children: [
                    TextSpan(
                        text: 'Log in',
                        style: textTheme.bodyText2,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                                context, Routes.login);
                          }),
                  ],
                ),
              ),
            ),
          ]),
    )));
  }
}
