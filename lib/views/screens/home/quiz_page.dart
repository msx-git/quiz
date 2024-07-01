import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../models/question.dart';
import '../result/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.questions,
    required this.pageController,
  });

  final List<QueryDocumentSnapshot> questions;
  final PageController pageController;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _foundCorrectAnswer = false;
  bool _didAnswer = false;
  int corrects = 0;
  int falses = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: _didAnswer,
          child: _foundCorrectAnswer
              ? Lottie.asset('assets/congrats.json')
              : const SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SafeArea(child: SizedBox(height: 20)),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    debugPrint("Page changed");
                    setState(() {
                      _didAnswer = false;
                      _foundCorrectAnswer = false;
                    });
                  },
                  controller: widget.pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.questions.length,
                  itemBuilder: (context, index) {
                    final question = Question.fromJson(widget.questions[index]);
                    return Column(
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          question.questionText,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 30),
                        ),
                        const SizedBox(height: 50),
                        ...List.generate(
                          question.answers.length,
                          (index2) {
                            return ListTile(
                              onTap: _didAnswer
                                  ? null
                                  : () {
                                      setState(() => _didAnswer = true);
                                      if (question.answers[index2].keys
                                              .toList()
                                              .first ==
                                          question.correctVariant) {
                                        setState(() {
                                          _foundCorrectAnswer = true;
                                          corrects++;
                                        });
                                      } else {
                                        setState(() {
                                          falses++;
                                        });
                                      }
                                      if (index ==
                                          widget.questions.length - 1) {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => ResultScreen(
                                              corrects: corrects,
                                              falses: falses,
                                            ),
                                          ),
                                          (route) => route is ResultScreen,
                                        );
                                      }
                                      Future.delayed(
                                        const Duration(seconds: 2),
                                        () {
                                          widget.pageController.nextPage(
                                            duration: const Duration(
                                              milliseconds: 400,
                                            ),
                                            curve: Curves.linear,
                                          );
                                        },
                                      );
                                    },
                              leading: Text(
                                question.answers[index2].keys.toList().first,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              title: Text(
                                '${question.answers[index2].values.toList().first}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                ),
                              ),
                            );
                          },
                        ),
                        Expanded(
                          child: Visibility(
                            visible: _didAnswer,
                            child: Center(
                              child: Lottie.asset(
                                _foundCorrectAnswer
                                    ? 'assets/tick.json'
                                    : 'assets/error.json',
                                height: 80,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
