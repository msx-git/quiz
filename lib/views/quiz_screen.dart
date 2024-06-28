import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz/controllers/quiz_controller.dart';
import 'package:quiz/models/question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _pageController = PageController();

  bool _foundCorrectAnswer = false;
  bool _didAnswer = false;

  @override
  Widget build(BuildContext context) {
    final quizController = context.watch<QuizController>();
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: StreamBuilder(
          stream: quizController.list,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text("There's not questions in the Quiz."),
              );
            }
            final questions = snapshot.data!.docs;
            if (questions.isEmpty) {
              return Text('No data');
            }
            return Stack(
              children: [
                Visibility(
                  visible: _didAnswer,
                  child: _foundCorrectAnswer
                      ? Stack(
                          children: [
                            Transform.flip(
                              flipX: true,
                              child: Lottie.asset('assets/clap.json'),
                            ),
                            Lottie.asset('assets/congrats.json'),
                          ],
                        )
                      : Stack(
                          children: [
                            Transform.flip(
                              flipX: true,
                              child: Lottie.asset('assets/thumbs_down.json'),
                            ),
                            Lottie.asset('assets/thumbs_down.json'),
                          ],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SafeArea(child: SizedBox(height: 20)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/gifs/face.gif',
                          height: 60,
                        ),
                      ),
                      //const SizedBox(height: 40),
                      Expanded(
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (value) {
                            setState(() {
                              _didAnswer = false;
                              _foundCorrectAnswer = false;
                            });
                          },
                          controller: _pageController,
                          scrollDirection: Axis.vertical,
                          itemCount: questions.length,
                          itemBuilder: (context, index) {
                            final question =
                                Question.fromJson(questions[index]);
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
                                      onTap: () {
                                        if (index == questions.length - 1) {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const Text("Resluts"),
                                            ),
                                          );
                                        }
                                        setState(() => _didAnswer = true);
                                        if (question.answers[index2].keys
                                                .toList()
                                                .first ==
                                            question.correctVariant) {
                                          setState(
                                              () => _foundCorrectAnswer = true);
                                        }
                                        Future.delayed(
                                          const Duration(seconds: 2),
                                          () {
                                            _pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.linear,
                                            );
                                          },
                                        );
                                      },
                                      leading: Text(
                                        question.answers[index2].keys
                                            .toList()
                                            .first,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      title: Text(
                                        '${question.answers[index2].values.toList().first}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 26),
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
          }),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.linear,
              );
            },
            icon: const Icon(
              CupertinoIcons.chevron_up,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.linear,
              );
            },
            icon: const Icon(
              CupertinoIcons.chevron_down,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
