import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/View/Screens/comment_screen.dart';
import 'package:tiktok_clone/View/widgets/circle_animation.dart';
import 'package:tiktok_clone/View/widgets/video_player.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/video_controller.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key});

  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profileURl) {
    return SizedBox(
      height: 60 ,
      width: 60,
      child: Stack(
        children: [
          Positioned(
              left: 5,
              child: Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image(image: NetworkImage(profileURl),fit: BoxFit.fill,),
            ),
          ),
          ),
        ],
      ),
    );
  }
  buildMusicAlbum(String profilePhoto){
    return SizedBox(
      height: 60,width: 60,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                CupertinoColors.systemGreen,
                Colors.green,
              ]),
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: const Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/tiktok-aec61.appspot.com/o/profilePic%2FjjxG5ySwnRbEd5xzl5Cqtam3tKW2?alt=media&token=05601aae-38b0-4c65-9769-8aebba7ae4ef')),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
          return PageView.builder(
              itemCount: videoController.videoList.length,
              controller: PageController(
                initialPage: 0,
                viewportFraction: 1,
              ),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final data = videoController.videoList[index];
                return Stack(
                  children: [
                    VideoPlayerItem(videoUrl: data.videoUrl),
                    Column(
                      children: [
                        Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 20,bottom: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.username,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                  Text(data.caption,style: TextStyle(fontSize: 15),),
                                  Row(
                                    children: [
                                      Icon(Icons.music_note,size: 15,),
                                      Text(data.songName, style: TextStyle(fontSize: 15),)
                                    ],
                                  ),
                                ],
                              ),
                            )
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: size.height/2.4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildProfile(data.profilePhoto),
                                   Column(
                                    children: [
                                      IconButton(
                                          onPressed: () { videoController.likeVideo(data.id); },
                                          icon: Icon(Icons.favorite,color: data.likes.contains(firebaseAuth.currentUser!.uid) ? Colors.red : Colors.white, size: 35,)),
                                      const SizedBox(height: 3,),
                                      Text(data.likes.length.toString(),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                   Column(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommentScreen(updateID: data.id,)));
                                          },
                                          child: Icon(CupertinoIcons.chat_bubble,size: 35,)),
                                      SizedBox(height: 3,),
                                      Text(data.commentCount.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(Icons.reply_outlined,size: 35,),
                                      SizedBox(height: 3,),
                                      data.shareCount == 0 ? Text('Share',style: TextStyle(fontWeight: FontWeight.w900),) :Text(data.shareCount.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                      CircleAnimation(child: buildMusicAlbum(data.profilePhoto))
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        ),
                      ],
                    ),
                  ],
                );
              });
        }
      ),
    );
  }
}
