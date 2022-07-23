import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/routes.dart';
import 'package:ninja_connect/src/features/profile/states/profile_state.dart';
import 'package:ninja_connect/src/repositories/authentication_repository.dart';
import 'package:ninja_connect/src/services/navigation_service.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  Reader reader;
  ProfileNotifier(this.reader) : super(ProfileState());

  void checkIsLoading() {
    state = state.update(isLoading: !state.isLoading);
  }

  User get user => reader(authenticationRepository).currentUser!;

  Future<void> logoutUser() async {
    await reader(authenticationRepository).signOut();

    reader(navigationService).navigateOffAllNamed(
      Routes.welcome,
      (_) => false,
    );
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>(
    (ref) => ProfileNotifier(ref.read));
