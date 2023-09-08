import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Model/Video.dart';
import 'package:tiktok_clone/constants.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(firebaseFireStore
        .collection('Videos')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(Video.fromSnap(element));
      }
      return retVal;
    }));
  }
  likeVideo(String id) async {
    DocumentSnapshot doc = await firebaseFireStore.collection('Videos').doc(id).get();
    var uid = firebaseAuth.currentUser!.uid;
    if((doc.data()! as dynamic) ['likes'].contains(uid)) {
      await firebaseFireStore.collection('Videos').doc(id).update({
        'likes' : FieldValue.arrayRemove([uid])
      });
    }else{
      await firebaseFireStore.collection('Videos').doc(id).update({
        'likes' : FieldValue.arrayUnion([uid])
      });
    }
  }
}
