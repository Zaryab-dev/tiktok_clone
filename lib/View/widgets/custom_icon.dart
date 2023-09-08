import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 45,
      child: Stack(
        children: [
          Container(
            width: 38,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(8)
            ),
          ),
          Container(
            width: 38,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8)
            ),
          ),
          Center(child: Container(
            height: 30,
            width: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7)
            ),
            child: Icon(Icons.add,color: Colors.black,),
          ),)
        ],
      ),
    );
  }
}
