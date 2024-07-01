import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz/controllers/auth_controller.dart';
import 'package:quiz/utils/extensions.dart';

import '../../../controllers/quiz_controller.dart';
import '../manage_quiz.dart';
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
      endDrawer: Drawer(
        backgroundColor: Colors.indigoAccent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Column(
          children: [
            const SafeArea(child: SizedBox(height: 50)),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ManageQuiz(),
                  ),
                );
              },
              title: Text(
                "Manage quiz",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              trailing: const Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            ListTile(
              onTap: () async {
                await context.read<AuthController>().signOut();
              },
              title: Text(
                "Sign Out",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              trailing: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
            20.height,
          ],
        ),
      ),
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
