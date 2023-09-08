import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/upload_video_controller.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen({super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller = VideoPlayerController.file(widget.videoFile);
  final _songController = TextEditingController();
  final _captionController = TextEditingController();
  UploadVideoController uploadVideoController = Get.put(UploadVideoController());
  @override
  void initState() {
    super.initState();
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }
  @override
  void dispose() {
    super.dispose();
    _captionController.dispose();
    _songController.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.width,
              child: VideoPlayer(controller),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  const SizedBox(height: 22,),
                  TextFormField(
                    controller: _songController,
                    decoration:  InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Color.containerColor)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Color.containerColor)
                      ),
                      label: const Text('Song Name'),
                      prefixIcon: const Icon(Icons.music_note),
                    ),
                  ),
                  const SizedBox(height: 11,),
                  TextFormField(
                    controller: _captionController,
                    decoration:  InputDecoration(
                      label: const Text('Caption'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Color.containerColor)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(color: Color.containerColor)
                      ),
                      prefixIcon: const Icon(Icons.closed_caption),
                    ),
                  ),
                  const SizedBox(height: 11,),
                  ElevatedButton(onPressed: () {
                    uploadVideoController.uploadVideo(widget.videoPath, _songController.text, _captionController.text);
                  }, child: const Text("Share!"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
