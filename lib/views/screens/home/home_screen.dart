import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/views/widgets/app_drawer.dart';

import '../../../controllers/quiz_controller.dart';
import 'quiz_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final quizController = context.read<QuizController>();
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.indigoAccent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        leading: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Image.asset(
              'assets/gifs/face.gif',
              height: 70,
            ),
          ],
        ),
      ),
      endDrawer: const AppDrawer(),
      body: StreamBuilder(
        stream: quizController.list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const Center(
              child: Text("No questions"),
            );
          }
          final questions = snapshot.data!.docs;
          return QuizScreen(
              questions: questions, pageController: _pageController);
        },
      ),
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
