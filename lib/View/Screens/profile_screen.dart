import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class ProfileScreen extends StatelessWidget {
  String uid;
  ProfileScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.person_add_alt_1)),
        title: const Text('username', style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 122,),
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: 'https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=900&q=60',
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url , error) => const Icon(Icons.error_outline, color: Colors.red,),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 42,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 42),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('12', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        Text('Following', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),),
                      ],
                    ),
                    Column(
                      children: [
                        Text('2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        Text('Followers', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),),
                      ],
                    ),
                    Column(
                      children: [
                        Text('123', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        Text('Likes', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(child: Text('Sign Out', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),),
              ),
            ], 
          ),
        ],
      ),
    );
  }
}
