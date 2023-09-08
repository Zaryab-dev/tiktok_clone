import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/View/Screens/add_post_screen.dart';
import 'package:tiktok_clone/View/Screens/profile_screen.dart';
import 'package:tiktok_clone/View/Screens/search_screen.dart';
import 'package:tiktok_clone/View/Screens/video_screen.dart';

class Color{
  static const backgroundColor = CupertinoColors.black;
  static const buttonColor = CupertinoColors.activeGreen;
  static const borderColor = CupertinoColors.extraLightBackgroundGray;
  static const containerColor = CupertinoColors.activeGreen;
}

class Utils {
  void showSnackbar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
  }
}
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firebaseFireStore = FirebaseFirestore.instance;

List pages = [
  VideoScreen(),
  SearchScreen(),
  const AddPostScreen(),
  Center(child: Text('Message Screen'),),
  ProfileScreen(uid: firebaseAuth.currentUser!.uid),
];
