import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';

import '../Model/user.dart';

class SearchedController extends GetxController {
  final Rx<List<User>> _searchedUsersList = Rx<List<User>>([]);

  List<User> get searchedUsersList => _searchedUsersList.value;

  searchUsers(String typedUser) async {
    _searchedUsersList.bindStream(firebaseFireStore
        .collection('Users')
        .where('name', isEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retVal = [];
      for (var element in query.docs) {
        retVal.add(User.fromSnap(element));
      }
      return retVal;
    }));
  }
}
