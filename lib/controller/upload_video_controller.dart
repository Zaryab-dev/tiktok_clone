import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Model/Video.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends  GetxController {
  // static UploadVideoController instance = Get.find();
  _compressVideo(String videoPath) async{
    final compressedVideo = await VideoCompress.compressVideo(videoPath, quality: VideoQuality.DefaultQuality);
    return compressedVideo!.file;
  }

   Future<String> _uploadVideoStorage(String id, videoPath) async{
    Reference ref = firebaseStorage.ref().child('Videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    final downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async{
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

   Future<String> _uploadImageToStorage(String id, videoPath) async{
    Reference ref = firebaseStorage.ref().child('Thumbnail').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    final downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String videoPath, String songName, String caption) async{
    try{
      final uid = firebaseAuth.currentUser!.uid;
      var userDoc = await firebaseFireStore.collection('Users').doc(uid).get();
      var allDoc = await firebaseFireStore.collection('Videos').get();
      int len = allDoc.docs.length;
      String videoUrl = await _uploadVideoStorage("Videos $len", videoPath);
      String thumbnail = await _uploadImageToStorage("Videos $len", videoPath);
      
      Video video = Video(thumbnail: thumbnail, videoUrl: videoUrl, id: 'Video $len', uid: uid,
          username: (userDoc.data()!)['name'], caption: caption, commentCount: 0, likes: [],
          profilePhoto: (userDoc.data()!)['photoUrl'], shareCount: 0, songName: songName
      );
      await firebaseFireStore.collection('Videos').doc('Video $len').set(video.toJson());
      Get.back();
      Get.snackbar('Success', 'Video Uploaded successfully!');
    } catch(e) {
      Get.snackbar('Error while uploading video', e.toString());
      print(e.toString());
    }
  }
}