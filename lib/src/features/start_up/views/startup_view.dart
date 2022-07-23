import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';
import 'package:ninja_connect/src/core/routes.dart';
import 'package:ninja_connect/src/core/utilities/hive_keys.dart';
import 'package:ninja_connect/src/services/database_services.dart';
import 'package:ninja_connect/src/services/navigation_service.dart';
import 'package:ninja_connect/src/widgets/status_bar.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    decideNavigation();
    super.initState();
  }

  void decideNavigation() async {
    await Future.delayed(const Duration(seconds: 4), () {
      if (ref.read(hiveProvider).get(HiveKeys.viewed) == true) {
        ref.read(navigationService).navigateOffNamed(Routes.naija);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.onboard);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Statusbar(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '9ja',
                  style: textTheme.headline2,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Connect',
                      textStyle: textTheme.headline2?.copyWith(
                        color: AppColors.lightBlue,
                        fontSize: 28,
                      ),
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                  totalRepeatCount: 1,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
