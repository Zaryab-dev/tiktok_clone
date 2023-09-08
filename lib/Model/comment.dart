import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String uid;
  String id;
  String profilePhoto;
  String comment;
  List likes;
  final datePublished;

  Comment(
      {required this.username,
      required this.uid,
      required this.id,
      required this.profilePhoto,
      required this.comment,
      required this.likes,
      required this.datePublished});

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'id': id,
        'profilePhoto': profilePhoto,
        'comment': comment,
        'likes': likes,
        'datePublished': datePublished,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
        username: snapshot['username'],
        uid: snapshot['uid'],
        id: snapshot['id'],
        profilePhoto: snapshot['profilePhoto'],
        comment: snapshot['comment'],
        likes: snapshot['likes'],
        datePublished: snapshot['datePublished']);
  }
}
