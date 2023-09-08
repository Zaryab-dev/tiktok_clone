import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';

import '../../controller/auth_controller.dart';
import '../widgets/text_input.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  Uint8List? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  const Text('TikTok Clone', style: TextStyle(color: Color.containerColor,fontSize: 45,fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,),
                  const SizedBox(height: 23,),
                  const Text('Sign Up', style: TextStyle(color: Color.containerColor, fontSize: 23,fontWeight: FontWeight.w900),),
                  const SizedBox(height: 23,),
                  Stack(
                    children: [
                      _image != null ? CircleAvatar(
                  backgroundColor: CupertinoColors.systemGrey5,
                    backgroundImage: MemoryImage(_image!),
                    radius: 80,
                  ) :
                      const CircleAvatar(
                        backgroundColor: CupertinoColors.systemGrey5,
                        backgroundImage: NetworkImage('https://images.pexels.com/photos/16299704/pexels-photo-16299704/free-photo-of-his-favourite.jpeg?auto=compress&cs=tinysrgb&w=800&lazy=load'),
                        radius: 80,
                      ),
                      Positioned(
                          bottom: -10,
                          right: 5,
                          child: IconButton(onPressed: () {
                            getImage();
                          }, icon: Icon(Icons.add_a_photo_sharp,color: Color.containerColor,size: 29,)))
                    ],
                  ),
                  SizedBox(height: 17,),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextInputField(labelText: 'Username', icon: Icons.person, textInputAction: TextInputAction.next, controller: _usernameController)),
                  SizedBox(height: 13,),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextInputField(labelText: 'Email', icon: Icons.alternate_email, textInputAction: TextInputAction.next, controller: _emailController)),
                  SizedBox(height: 13,),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextInputField(isObscure: true, labelText: 'Password', icon: Icons.lock, textInputAction: TextInputAction.done, controller: _passwordController)),
                  SizedBox(height: 23,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.buttonColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: InkWell(
                        onTap: () => AuthController.instance.registerUser(_emailController.text, _passwordController.text, _usernameController.text, _image!),
                        child: const Center(child: Text('Register',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),))),
                  ),
                  SizedBox(height: 23,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: const Text('Login', style: TextStyle(color: Color.containerColor, fontWeight: FontWeight.bold,fontSize: 17),))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  pickImage(ImageSource imageSource) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? _file = await imagePicker.pickImage(source: imageSource);
    if(_file != null) {
      return await _file.readAsBytes();
    }
    // ignore: use_build_context_synchronously
    Utils().showSnackbar("No Image Selected!", context);
  }
  Future<void> getImage() async{
    final file = await pickImage(ImageSource.gallery);
    setState(() {
      _image = file;
    });
  }
}
