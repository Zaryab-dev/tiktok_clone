import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Video {
  String uid;
  String id;
  String username;
  String profilePhoto;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  List likes;
  int commentCount;
  int shareCount;

  Video({
    required this.thumbnail,
    required this.videoUrl,
    required this.id,
    required this.uid,
    required this.username,
    required this.caption,
    required this.commentCount,
    required this.likes,
    required this.profilePhoto,
    required this.shareCount,
    required this.songName,
  });

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'uid': uid,
        'songName': songName,
        'thumbnail': thumbnail,
        'videoUrl': videoUrl,
        'caption': caption,
        'commentCount': commentCount,
        'shareCount': shareCount,
        'profilePhoto': profilePhoto,
        'likes': likes,
        'id': id,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
        thumbnail: snapshot['thumbnail'],
        videoUrl: snapshot['videoUrl'],
        id: snapshot['id'],
        uid: snapshot['uid'],
        username: snapshot['username'],
        caption: snapshot['caption'],
        commentCount: snapshot['commentCount'],
        likes: snapshot['likes'],
        profilePhoto: snapshot['profilePhoto'],
        shareCount: snapshot['shareCount'],
        songName: snapshot['songName']);
  }
}
