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
  bool gameOver = false;
  double xAxisBarrier = 1;
  double xAxisBarrier2 = 3;

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

      t += 0.05;
      height = -(t*t * (g / 2)) + (v * t);
      setState(() {
        yAxisBird = initHeight - height;
        yAxisBird = min(yAxisBird, 1);
        if (!gameOver) {
          xAxisBarrier -= 0.07;
          if (xAxisBarrier <= -2) {
            xAxisBarrier = 2;
          }
          xAxisBarrier2 -= 0.07;
          if (xAxisBarrier2 <= -2) {
            xAxisBarrier2 = 2;
          }
        }

        // yAxisBird = max(yAxisBird, -1);
      });

      if (yAxisBird >= 1) {
        gameStarted = false;
        yAxisBird = 1;
        gameOver = true;
        timer.cancel();
      }



    });

  }

  Widget scoreText(text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
    );
  }

  Widget makeBarrier(flex1, flex2, flex3) {
    return Container(
      width: 100,
      child: Column(
        children: [
          Expanded(
              flex: flex1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,  // Pipe color
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),  // Rounded corners for a pipe-like effect
                border: Border(
                    left: BorderSide(
                      color: Colors.green[800]!,  // Darker shade for the pipe border
                      width: 5,
                    ),
                    right: BorderSide(
                      color: Colors.green[800]!,  // Darker shade for the pipe border
                      width: 5,
                    ),
                    bottom: BorderSide(
                      color: Colors.green[800]!,  // Darker shade for the pipe border
                        width: 5,
                    ),

                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),  // Shadow position
                    blurRadius: 5,  // Shadow blur for depth
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: flex2,
            child: SizedBox(),
          ),
          Expanded(
            flex: flex3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,  // Pipe color
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),  // Rounded corners for a pipe-like effect
                border: Border(
                  left: BorderSide(
                    color: Colors.green[800]!,  // Darker shade for the pipe border
                    width: 5,
                  ),
                  right: BorderSide(
                    color: Colors.green[800]!,  // Darker shade for the pipe border
                    width: 5,
                  ),
                  top: BorderSide(
                    color: Colors.green[800]!,  // Darker shade for the pipe border
                    width: 5,
                  ),

                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),  // Shadow position
                    blurRadius: 5,  // Shadow blur for depth
                  ),
                ],
              ),
            ),
          ),
        ],
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
              child: Stack(
                children: [
                  AnimatedContainer(
                    color: Colors.blue,
                    alignment: Alignment(0, yAxisBird),
                    duration: Duration(milliseconds: 0),
                    child: Bird(),
                  ),
                  Center(
                    child: Text(
                      gameOver ? "G A M E   O V E R": (gameStarted ? "" : "T A P   T O   P L A Y"),
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(xAxisBarrier, 0),
                      child: makeBarrier(4, 3, 4),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(xAxisBarrier2, 0),
                    child: makeBarrier(2, 3, 5),
                  )
                ],
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
