import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Model/comment.dart';
import 'package:tiktok_clone/constants.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _commentList = Rx<List<Comment>>([]);

  List<Comment> get commentList => _commentList.value;
  String _postID = '';

  updatePostId(String id) {
    _postID = id;
    getComment();
  }
  getComment() async {
    _commentList.bindStream(firebaseFireStore.collection('Videos').doc(_postID).collection('Comments').snapshots().map((QuerySnapshot query) {
      List<Comment> retVal = [];
      for(var element in query.docs) {
        retVal.add(Comment.fromSnap(element));
      }
      return retVal;
    }));
  }

  postComment(String commentText) async {
    try{
      if(commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firebaseFireStore
            .collection('Users')
            .doc(firebaseAuth.currentUser!.uid)
            .get();
        var allDoc = await firebaseFireStore
            .collection('Videos')
            .doc(_postID)
            .collection('Comments')
            .get();
        int len = allDoc.docs.length;
        Comment comment = Comment(
            username: (userDoc.data() as dynamic)['name'],
            uid: firebaseAuth.currentUser!.uid,
            id: 'Comments $len',
            profilePhoto: (userDoc.data() as dynamic)['photoUrl'],
            comment: commentText.trim(),
            likes: [],
            datePublished: DateTime.now());
        await firebaseFireStore.collection('Videos').doc(_postID).collection('Comments').doc('Comments $len').set(comment.toJson());
        DocumentSnapshot doc = await firebaseFireStore.collection("Videos").doc(_postID).get();
        await firebaseFireStore.collection('Videos').doc(_postID).update({
          'commentCount' : (doc.data() as dynamic)['commentCount'] + 1
        });
      }
      Get.snackbar("SUCCESS", "Comment Posted!");
    } catch(e) {
      Get.snackbar('Error', e.toString());
    }
  }
  likeComment(String id) async{
    var uid = firebaseAuth.currentUser!.uid;
    DocumentSnapshot doc = await firebaseFireStore.collection('Videos').doc(_postID).collection('Comments').doc(id).get();
    if((doc.data()! as dynamic)['likes'].contains(uid)) {
       firebaseFireStore.collection('Videos').doc(_postID).collection('Comments').doc(id).update({
        'likes' : FieldValue.arrayRemove([uid])
      });
    }else{
         firebaseFireStore.collection('Videos').doc(_postID).collection('Comments').doc(id).update({
          'likes' : FieldValue.arrayUnion([uid])
        });
    }
  }
}