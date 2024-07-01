import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../home/home_screen.dart';
import '../home/quiz_page.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.corrects, required this.falses});

  final int corrects;
  final int falses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Correct: $corrects\nWrong: $falses",
            textAlign: TextAlign.center,
          )),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (route) => route is QuizScreen,
              );
            },
            child: const Text("Restart"),
          )
        ],
      ),
    );
  }
}
