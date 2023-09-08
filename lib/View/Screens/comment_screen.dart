import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/comment_controller.dart';
import 'package:timeago/timeago.dart' as toago;

class CommentScreen extends StatelessWidget {
  String updateID;
  CommentScreen({super.key, required this.updateID});

  final commentController = TextEditingController();
  // DocumentSnapshot snapshot = await firebaseFireStore.collection('Users').doc(firebaseAuth.currentUser!.uid).get();
  CommentController controller = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    controller.updatePostId(updateID);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                    return ListView.builder(
                        itemCount: controller.commentList.length,
                        itemBuilder: (context, index) {
                          final comment = controller.commentList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: CupertinoColors.systemGrey4,
                          backgroundImage: NetworkImage(comment.profilePhoto),
                        ),
                        title: Row(
                          children: [
                            Text(comment.username, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17,color: Color.containerColor),),
                            SizedBox(width: 5,),
                            Text(comment.comment, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(toago.format(comment.datePublished.toDate())),
                            const SizedBox(width: 5,),
                            comment.likes.isEmpty ? const Text('No Likes') :
                            Text('${comment.likes.length} Likes'),
                          ],
                        ),
                        trailing: IconButton(onPressed: () =>
                          controller.likeComment(comment.id)
                        , icon: comment.likes.contains(firebaseAuth.currentUser!.uid) ? Icon(Icons.favorite_border,color: Colors.red,) :Icon(Icons.favorite_border)),
                      );
                    });
                  }
                ),
              ),
              SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.shade900
                  ),
                  child: ListTile(
                    title: TextFormField(
                      controller: commentController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade900,width: 0)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade900)
                        ),
                        hintText: 'Enter your comment',
                        hintStyle: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    trailing: TextButton(onPressed: () {
                      controller.postComment(commentController.text);
                       commentController.clear();
                    }, child: Text('Send', style: TextStyle(fontWeight: FontWeight.w700, color: Color.containerColor),)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
