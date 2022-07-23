import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/utilities/hive_keys.dart';
import 'package:ninja_connect/src/features/authentication/models/app_user.dart';
import 'package:ninja_connect/src/repositories/users_repository.dart';
import 'package:ninja_connect/src/services/database_services.dart';
import 'package:ninja_connect/src/services/failure.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

class AuthenticationRepository {
  final Reader reader;

  AuthenticationRepository(this.reader);
  User? get currentUser => FirebaseAuth.instance.currentUser;

//Register
  Future<AppUser> registerRepository({
    required String email,
    required String displayName,
    required String password,
  }) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
      await reader(userRepository).createUserWithId(credential.user!.uid,
          userName: displayName, email: email);
      await reader(hiveProvider).put(HiveKeys.userId, credential.user!.uid);
      await credential.user!.sendEmailVerification();
      return reader(userRepository).getFutureUser(credential.user!.uid);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

//Sign in
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!credential.user!.emailVerified) {
        await FirebaseAuth.instance.signOut();
        throw const Failure('Email is not verified');
      }
      return reader(userRepository).getFutureUser(credential.user!.uid);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

//Sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

// Update user
  Future<void> updateUser({required String fullName}) async {
    try {
      await currentUser!.updateDisplayName(fullName);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }
}

final authenticationRepository = Provider(
  (ref) => AuthenticationRepository(ref.read),
);
