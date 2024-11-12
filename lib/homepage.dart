import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  double yAxisBird = 0;
  
  void drop() {
    double g = 0.01;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        yAxisBird += g;
        if (g < 0.1) {
          g += 0.01;
        }

      });
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: drop,
              child: AnimatedContainer(
                color: Colors.blue,
                alignment: Alignment(0, yAxisBird),
                duration: Duration(milliseconds: 0),
                child: Bird(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
            ),
          ),
        ],
      ),

    );
  }
}
