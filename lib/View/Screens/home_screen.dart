import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/View/auth_screen/login_screen.dart';
import 'package:tiktok_clone/constants.dart';

import '../widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      // leading: IconButton(onPressed: () {
      //   firebaseAuth.signOut().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen())));
      // }, icon: Icon(Icons.logout)),),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home,),label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search,),label: "Search"),
          BottomNavigationBarItem(
              icon: CustomIcon(),label: ""),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble,),label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person,),label: "Profile"),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}
