import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 130,
        height: 130,
        child: Image.asset("lib/images/bird.png"),
    );
  }
}
