import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String userName;
  final String email;

  const AppUser({
    required this.id,
    required this.userName,
    required this.email,
  });

  factory AppUser.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      AppUser(
        id: snapshot.id,
        userName: snapshot.data()!['userName'],
        email: snapshot.data()!['email'],
      );
}
