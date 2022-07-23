import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/features/authentication/views/login_view.dart';
import 'package:ninja_connect/src/features/home/views/dashboard_view.dart';
import 'package:ninja_connect/src/features/profile/views/profile_view.dart';
import 'package:ninja_connect/src/features/provider/app_user_providers.dart';
import 'package:ninja_connect/src/repositories/authentication_repository.dart';
import 'package:ninja_connect/src/widgets/two_colored_text.dart';

class AuthenticationWrapper extends HookConsumerWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider);

    return user.when(
      data: (user) {
        if (user == null) {
          return const LoginView();
        } else {
          final appUser = ref.watch(appUserProvider);
          return appUser.maybeWhen(
            data: (appUser) => appUser == appUser
                ? DashboardView(user: appUser)
                : const Scaffold(body: Center(child: Text('Hackers Alert!⛔'))),
            orElse: () => const Scaffold(
                body: Center(
                    child: TwoColoredText(
              first: '9ja',
              second: 'Connect',
              fontSize: 28,
            ))),
          );
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const Scaffold(body: Center(child: Text('Error'))),
    );
  }
}
