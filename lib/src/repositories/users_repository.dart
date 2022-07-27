import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/features/authentication/models/app_user.dart';

class UserRepository {
  UserRepository();

  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<AppUser> getFutureUser(String userId) async {
    final snapshot = await userCollection.doc(userId).get();
    return AppUser.fromMap(snapshot);
  }

  // Stream<AppUser> getUser(String userId) {
  //   return userCollection.doc(userId).snapshots().map(
  //         (documentSnapshot) => AppUser.fromMap(
  //           documentSnapshot,
  //         ),
  //       );
  // }

  Future<void> createUserWithId(
    String userId, {
    required String userName,
    required String email,
  }) async {
    return await userCollection.doc(userId).set({
      'userName': userName,
      'email': email,
      'timestamp': Timestamp.now(),
    });
  }

  Future<AppUser> updateUserWithId(
    String userId, {
    required String userName,
  }) async {
    await userCollection.doc(userId).update({
      'userName': userName,
    });

    return getFutureUser(userId);
  }
}

final userRepository = Provider<UserRepository>((ref) => UserRepository());
