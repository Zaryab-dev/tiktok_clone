
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email, name, photoUrl, uid;

  User({
    required this.uid,
    required this.name,
    required this.photoUrl,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'photoUrl': photoUrl,
        'email': email,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        uid: snapshot['uid'],
        name: snapshot['name'],
        photoUrl: snapshot['photoUrl'],
        email: snapshot['email']);
  }
}
