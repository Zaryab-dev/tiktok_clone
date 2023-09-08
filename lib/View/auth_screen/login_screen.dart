import 'package:flutter/material.dart';
import 'package:tiktok_clone/View/auth_screen/sign_up_screen.dart';
import 'package:tiktok_clone/constants.dart';

import '../../controller/auth_controller.dart';
import '../widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                  const Text('Login', style: TextStyle(color: Color.containerColor, fontSize: 23,fontWeight: FontWeight.w900),),
                  const SizedBox(height: 23,),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextInputField(labelText: 'Email', icon: Icons.alternate_email, textInputAction: TextInputAction.next, controller: _emailController)),
                  SizedBox(height: 33,),
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
                      onTap: () => AuthController.instance.loginUser(_emailController.text, _passwordController.text, context),
                      child: const Center(child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),)),)
                  ),
                  const SizedBox(height: 23,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don\'t have an account? "),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpScreen()));
                        },
                          child: const Text('Register', style: TextStyle(color: Color.containerColor,fontSize: 17, fontWeight: FontWeight.bold),))
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
}
