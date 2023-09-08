import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class TextInputField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final bool isObscure;
  final String labelText;
  final IconData icon;
  final TextInputAction textInputAction;

  TextInputField({super.key,required this.labelText, required this.icon, required this.textInputAction, required this.controller,this.isObscure = false });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        label: Text(labelText),
        labelStyle: const TextStyle(fontSize: 17),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color.borderColor),
        ),
      ),
    );
  }
}
