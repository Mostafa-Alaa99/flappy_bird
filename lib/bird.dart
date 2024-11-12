import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0), // Adjust based on the hidden part
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: 0.65, // Adjust to focus on the visible bird part
          child: Image.asset("lib/images/bird.png", width: 130, height: 130,),
        ),
      ),
    );

  }
}
