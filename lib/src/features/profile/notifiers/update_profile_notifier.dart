import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/features/profile/states/update_profile_state.dart';
import 'package:ninja_connect/src/repositories/authentication_repository.dart';
import 'package:ninja_connect/src/services/failure.dart';
import 'package:ninja_connect/src/services/navigation_service.dart';
import 'package:ninja_connect/src/services/snackbar_service.dart';

class UpdateProfileNotifier extends StateNotifier<UpdateProfileState> {
  Reader reader;
  UpdateProfileNotifier(this.reader) : super(UpdateProfileState());

  void checkIsLoading() {
    state = state.update(isLoading: !state.isLoading);
  }

  Future<void> updateProfile(String fullName) async {
    state = state.update(isLoading: true);

    try {
      await reader(authenticationRepository).updateUser(fullName: fullName);

      reader(navigationService).navigateBack();

      reader(snackbarService).showSuccessSnackBar('Profile Update Successful');
    } on Failure catch (ex) {
      reader(navigationService).navigateBack();

      reader(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.update(isLoading: false);
    }
  }
}

final updateProfileProvider =
    StateNotifierProvider<UpdateProfileNotifier, UpdateProfileState>(
        (ref) => UpdateProfileNotifier(ref.read));
