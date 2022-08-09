import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/features/forum/models/forum_model.dart';
import 'package:ninja_connect/src/features/forum/states/add_forum_state.dart';
import 'package:ninja_connect/src/repositories/authentication_repository.dart';
import 'package:ninja_connect/src/repositories/forum_repository.dart';
import 'package:ninja_connect/src/services/failure.dart';
import 'package:ninja_connect/src/services/navigation_service.dart';
import 'package:ninja_connect/src/services/snackbar_service.dart';

class AddForumNotifier extends StateNotifier<AddForumState> {
  FirebaseStorage storage = FirebaseStorage.instance;

  AddForumNotifier(this.reader) : super(AddForumState());
  Reader reader;

  Future<void> addForum(ForumParams params) async {
    state = state.update(isLoading: true);
    final user = reader(authenticationRepository).currentUser;
    try {
      await reader(forumRepositoryProvider).createForum(
        params: params,
        creatorName: user!.displayName!,
      );
      reader(navigationService).navigateBack();
      reader(snackbarService).showSuccessSnackBar('Forum Created Successfully');
    } on Failure catch (ex) {
      reader(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.update(isLoading: false);
    }
  }

  Future<String> uploadImage(String imagePath) async {
    Reference ref =
        storage.ref().child('forumImages${DateTime.now().toIso8601String()}');
    await ref.putFile(File(imagePath));
    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }
}

final addForumNotifierProvider =
    StateNotifierProvider<AddForumNotifier, AddForumState>(
        (ref) => AddForumNotifier(ref.read));
