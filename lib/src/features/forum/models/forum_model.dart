import 'package:cloud_firestore/cloud_firestore.dart';

class Forum {
  final String id;
  final String forumName;
  final String imageUrl;
  final String summary;
  final String about;
  final String creatorName;
  final Timestamp timestamp;

  Forum({
    required this.id,
    required this.forumName,
    required this.imageUrl,
    required this.summary,
    required this.about,
    required this.creatorName,
    required this.timestamp,
  });

  factory Forum.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      Forum(
        id: snapshot.id,
        forumName: snapshot.data()?['forumName'],
        imageUrl: snapshot.data()?['imageUrl'],
        summary: snapshot.data()?['summary'],
        about: snapshot.data()?['about'],
        creatorName: snapshot.data()?['creatorName'],
        timestamp: snapshot.data()?['timestamp'],
      );
}

class ForumParams {
  final String forumName;
  final String imageUrl;
  final String summary;
  final String about;

  ForumParams({
    required this.forumName,
    required this.imageUrl,
    required this.summary,
    required this.about,
  });

  Map<String, dynamic> toMap() => {
        'forumName': forumName,
        'imageUrl': imageUrl,
        'summary': summary,
        'about': about,
        'timestamp': Timestamp.now(),
      };
}
