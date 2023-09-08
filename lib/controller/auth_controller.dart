import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Model/user.dart' as model;
import 'package:tiktok_clone/View/Screens/home_screen.dart';
import 'package:tiktok_clone/View/auth_screen/login_screen.dart';
import '../constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if(user == null) {
      Get.offAll(() => LoginScreen());
    }
    else{
      Get.offAll(() => HomeScreen());
    }
  }

  Future<String> uploadImageToStorage(Uint8List image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePic')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser(
    String email,
    password,
    username,
    Uint8List image,
  ) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) =>                 Get.snackbar("Success", 'Account created successfully!'))
            .onError(
                (error, stackTrace) => Get.snackbar("Error", error.toString()));
        String downloadUrl = await uploadImageToStorage(image);
        model.User user = model.User(
            uid: firebaseAuth.currentUser!.uid,
            name: username,
            photoUrl: downloadUrl,
            email: email);
        await firebaseFireStore
            .collection('Users')
            .doc(firebaseAuth.currentUser!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
            'Error While Creating Account', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error while Creating Account', e.toString());
    }
  }

  void loginUser(String email, password, BuildContext context) {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Get.snackbar("Success", "Login successfully!");
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
        })
            .onError(
                (error, stackTrace) {Get.snackbar('Error', error.toString());});
      } else {
        Get.snackbar("Empty Credential", 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar("Error while logging in", e.toString());
    }
  }
}
