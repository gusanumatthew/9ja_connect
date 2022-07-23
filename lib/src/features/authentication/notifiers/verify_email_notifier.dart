import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/routes.dart';
import 'package:ninja_connect/src/repositories/authentication_repository.dart';
import 'package:ninja_connect/src/services/navigation_service.dart';

class VerifyEmailNotifier extends StateNotifier<void> {
  final Reader reader;
  VerifyEmailNotifier(this.reader) : super(null);

  Future<void> navigateToLogin() async {
    await reader(authenticationRepository).signOut();

    reader(navigationService).navigateOffNamed(Routes.login);
  }
}

final verifyEmailNotifierProvider =
    StateNotifierProvider.autoDispose<VerifyEmailNotifier, void>(
  (ref) => VerifyEmailNotifier(ref.read),
);
