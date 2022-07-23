import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/constants/strings.dart';
import 'package:ninja_connect/src/features/authentication/notifiers/verify_email_notifier.dart';
import 'package:ninja_connect/src/widgets/app_buttons.dart';
import 'package:ninja_connect/src/widgets/spacing.dart';
import 'package:ninja_connect/src/widgets/status_bar.dart';
import 'package:ninja_connect/src/widgets/two_colored_text.dart';

class VerifyEmailView extends ConsumerWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Statusbar(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: Center(
              child: SizedBox(
                width: 500,
                child: Card(
                  color: colorScheme.primary.withOpacity(0.1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TwoColoredText(
                          first: '9ja',
                          second: 'Connect',
                          fontSize: 28,
                        ),
                        const Spacing.mediumHeight(),
                        Icon(
                          Icons.mail,
                          size: 36,
                          color: colorScheme.primary,
                        ),
                        const Spacing.bigHeight(),
                        Text(
                          AppStrings.verifyMail,
                          style: textTheme.headline5,
                        ),
                        const Spacing.smallHeight(),
                        Center(
                          child: Text(
                            AppStrings.verifyMailText,
                            textAlign: TextAlign.center,
                            style: textTheme.subtitle2,
                          ),
                        ),
                        const Spacing.bigHeight(),
                        SizedBox(
                          width: 150,
                          child: AppButton(
                            label: AppStrings.goToLogin,
                            onPressed: () async => await ref
                                .read(verifyEmailNotifierProvider.notifier)
                                .navigateToLogin(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
