
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/View/Screens/profile_screen.dart';
import 'package:tiktok_clone/constants.dart';

import '../../controller/search_controller.dart';
import 'package:tiktok_clone/Model/user.dart';


class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchedController searchController = Get.put(SearchedController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              onChanged: (value) => searchController.searchUsers(value),
              enabled: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: 'Search',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          body: searchController.searchedUsersList.isEmpty ? const Center(child: Text(
            'Searched For Users!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),) : ListView.builder(
              itemCount: searchController.searchedUsersList.length,
              itemBuilder: (context, index) {
                User user = searchController.searchedUsersList[index];
              return InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(uid: firebaseAuth.currentUser!.uid))),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: CupertinoColors.systemGrey5,
                    backgroundImage: NetworkImage(user.photoUrl),
                  ),
                  title: Text(user.name,style: const TextStyle(fontWeight: FontWeight.bold),),
                ),
              );
          }),
        );
      }
    );
  }
}
