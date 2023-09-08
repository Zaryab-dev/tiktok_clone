import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/View/Screens/confirm_screen.dart';
import 'package:tiktok_clone/constants.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: InkWell(
        onTap: () {showSimpleDialog(context);},
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(color: Color.containerColor,borderRadius: BorderRadius.circular(50)),
          child: const Center(child: Text("Add Video",style: TextStyle(fontWeight: FontWeight.w900),),),
        ),
      ));
  }
  Future<dynamic> showSimpleDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) => SimpleDialog(
      backgroundColor: Color.containerColor,
      children: [
        SimpleDialogOption(
          onPressed: () {
            getGalleryImage();
            Navigator.pop(context);
          },
          child: const Row(
            children: [
              Icon(Icons.image),SizedBox(width: 10,),
              Text('Gallery',style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            getCameraImage();
            Navigator.pop(context);
          },
          child: const Row(
            children: [
              Icon(Icons.camera),SizedBox(width: 10,),
              Text('Camera',style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ],
    ));
  }
  selectImage(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? _file = await imagePicker.pickVideo(source: imageSource);
    if(_file != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmScreen(
        videoFile: File(_file.path),
        videoPath: _file.path,
      )));
      return await _file.readAsBytes();
    }
    // ignore: use_build_context_synchronously
    Utils().showSnackbar('No video is chosen!', context);
  }
  getGalleryImage() {
    final file = selectImage(ImageSource.gallery);
    setState(() {

    });
  }
  getCameraImage() {
    final file = selectImage(ImageSource.camera);
    setState(() {

    });
  }
}
