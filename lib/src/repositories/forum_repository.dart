import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/features/forum/models/forum_model.dart';
import 'package:ninja_connect/src/services/failure.dart';

class ForumRepository {
  CollectionReference<Map<String, dynamic>> get forumCollection =>
      FirebaseFirestore.instance.collection('forums');

  //add forum
  Future<void> createForum(
      {required String creatorName, required ForumParams params}) async {
    try {
      await forumCollection.add({
        'creatorName': creatorName,
        ...params.toMap(),
      });
    } catch (ex) {
      throw const Failure('Error creating forum');
    }
  }

  // get forum
  Stream<List<Forum>> getForum() {
    return forumCollection.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (queryDocumentSnapshot) =>
                    Forum.fromDocumentSnapshot(queryDocumentSnapshot),
              )
              .toList(),
        );
  }
}

final forumRepositoryProvider = Provider<ForumRepository>((ref) {
  return ForumRepository();
});

final forumsProvider = StreamProvider<List<Forum>>((ref) {
  return ref.watch(forumRepositoryProvider).getForum();
});
