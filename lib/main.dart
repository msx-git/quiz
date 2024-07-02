import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/controllers/leaderboard_controller.dart';

import 'controllers/auth_controller.dart';
import 'controllers/quiz_controller.dart';
import 'firebase_options.dart';
import 'utils/app_routes.dart';
import 'views/screens/auth/login_screen.dart';
import 'views/screens/auth/register_screen.dart';
import 'views/screens/home/home_screen.dart';
import 'views/screens/leaderboard/leader_board_screen.dart';
import 'views/screens/manage_quiz.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuizController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LeaderboardController(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final user = snapshot.data;

              return user == null ? const LoginScreen() : HomeScreen();
            },
          ),
          routes: {
            AppRoutes.home: (context) => HomeScreen(),
            AppRoutes.login: (context) => const LoginScreen(),
            AppRoutes.register: (context) => const RegisterScreen(),
            AppRoutes.manageQuiz: (context) => const ManageQuiz(),
            AppRoutes.leaderBoard: (context) => const LeaderBoardScreen(),
          },
        );
      },
    );
  }
}
