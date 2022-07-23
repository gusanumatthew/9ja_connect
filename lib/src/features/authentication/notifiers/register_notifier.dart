import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/routes.dart';
import 'package:ninja_connect/src/features/authentication/states/register_state.dart';
import 'package:ninja_connect/src/repositories/authentication_repository.dart';
import 'package:ninja_connect/src/repositories/users_repository.dart';
import 'package:ninja_connect/src/services/failure.dart';
import 'package:ninja_connect/src/services/navigation_service.dart';
import 'package:ninja_connect/src/services/snackbar_service.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  Reader reader;
  RegisterNotifier(this.reader) : super(RegisterState());
  void passwordVisibility() {
    state = state.update(obscureText: !state.obscureText);
  }

  void checkIsLoading() {
    state = state.update(isLoading: !state.isLoading);
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String displayName,
  }) async {
    state = state.update(isLoading: true);
    try {
      await reader(authenticationRepository).registerRepository(
          email: email, displayName: displayName, password: password);
      reader(snackbarService)
          .showSuccessSnackBar('Account Successfully created');
      reader(navigationService)
          .navigateOffAllNamed(Routes.verifyEmail, (_) => false);
    } on Failure catch (ex) {
      reader(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.update(isLoading: false);
    }
  }

  void navigateToLogin() => reader(navigationService).navigateBack();
}

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>(
    (ref) => RegisterNotifier(ref.read));
