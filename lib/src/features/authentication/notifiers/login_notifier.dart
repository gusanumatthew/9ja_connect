import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/routes.dart';

import 'package:ninja_connect/src/features/authentication/states/login_state.dart';
import 'package:ninja_connect/src/repositories/authentication_repository.dart';
import 'package:ninja_connect/src/repositories/users_repository.dart';
import 'package:ninja_connect/src/services/failure.dart';
import 'package:ninja_connect/src/services/navigation_service.dart';
import 'package:ninja_connect/src/services/snackbar_service.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  Reader reader;
  LoginNotifier(this.reader) : super(LoginState());
  void passwordVisibility() {
    state = state.update(obscureText: !state.obscureText);
  }

  void checkIsLoading() {
    state = state.update(isLoading: !state.isLoading);
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = state.update(isLoading: true);
    try {
      await reader(authenticationRepository).login(
        email: email,
        password: password,
      );

      final user = reader(authenticationRepository).currentUser;
      final appUser = await reader(userRepository).getFutureUser(user!.uid);
      reader(navigationService)
          .navigateOffNamed(Routes.naija, arguments: appUser);
    } on Failure catch (ex) {
      reader(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.update(isLoading: false);
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
    (ref) => LoginNotifier(ref.read));
