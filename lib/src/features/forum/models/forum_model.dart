//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ninja_connect/src/core/constants/images.dart';

class ForumModel {
  String? forumName;
  String? image;
  String? summary;
  String? description;
  String? id;
  String? userName;
  //Timestamp? timestamp;

  ForumModel({
    this.forumName,
    this.image,
    this.summary,
    this.description,
    this.id,
    this.userName,
    // this.timestamp,
  });
}

final forumItem = [
  ForumModel(
    forumName: 'App Update',
    image: AppImages.trip,
    summary:
        'Chat with Alena while we wait for a physician to join.Chat with Alena while we wait for a physician to join.Chat with Alena while we wait for a physician to join.',
    description: 'Chat with Alena while we wait for a physician to join.',
    id: '1',
    // timestamp: '',
  ),
  ForumModel(
    forumName: 'App Update',
    image: AppImages.trip,
    summary: 'Chat with Alena while we wait for a physician to join.',
    description: 'Chat with Alena while we wait for a physician to join.',
    id: '1',
    // timestamp: '',
  ),
  ForumModel(
    forumName: 'App Update',
    image: AppImages.trip,
    summary: 'Chat with Alena while we wait for a physician to join.',
    description: 'Chat with Alena while we wait for a physician to join.',
    id: '1',
    // timestamp: '',
  ),
];
