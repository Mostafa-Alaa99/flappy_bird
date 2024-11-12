import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Distance law -> s = -at^2 + vt + s0
  // s0 is the initial height
  // a here is the gravity which is 9.8 (Yes, real life gravity ^_^)

  static double yAxisBird = 0;
  double initHeight = yAxisBird;
  double height = 0;
  double g = 9.8;
  double t = 0;
  double v = 3;
  bool gameStarted = false;

  void jump() {
    print("jumped");
    setState(() {
      if (yAxisBird > -1) {
        t = 0;
        initHeight = yAxisBird;
      }


    });

  }

  void startGame() {
    print("start " + yAxisBird.toString());
    gameStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {

      t += 0.03;
      height = -(t*t * (g / 2)) + (v * t);
      setState(() {
        yAxisBird = initHeight - height;
        yAxisBird = min(yAxisBird, 1);
        // yAxisBird = max(yAxisBird, -1);
      });

      if (yAxisBird >= 1) {
        gameStarted = false;
        yAxisBird = 1;
        timer.cancel();
      }



    });

  }

  Widget scoreText(text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                if (gameStarted) {
                  jump();
                } else {
                  startGame();
                }
              },
              child: AnimatedContainer(
                color: Colors.blue,
                alignment: Alignment(0, yAxisBird),
                duration: Duration(milliseconds: 0),
                child: Bird(),
              ),
            ),
          ),
          Container(
            color: Colors.green,
            height: 20,
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      scoreText("Score"),
                      SizedBox(height: 15),
                      scoreText("0"),
                    ],
                  ),
                  SizedBox(width: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      scoreText("Best"),
                      SizedBox(height: 15),
                      scoreText("10"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}
