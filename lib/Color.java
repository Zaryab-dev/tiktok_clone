import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
