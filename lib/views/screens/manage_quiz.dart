import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/quiz_controller.dart';
import '../../models/question.dart';
import '../widgets/add_question_dialog.dart';

class ManageQuiz extends StatefulWidget {
  const ManageQuiz({super.key});

  @override
  State<ManageQuiz> createState() => _ManageQuizState();
}

class _ManageQuizState extends State<ManageQuiz> {
  @override
  Widget build(BuildContext context) {
    final questionController = context.watch<QuizController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Quiz"),
      ),
      body: StreamBuilder(
        stream: questionController.list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text("There's not questionController in the Quiz."),
            );
          }
          final questions = snapshot.data!.docs;
          if (questions.isEmpty) {
            return const Text('No data');
          }
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = Question.fromJson(questions[index]);
              return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  leading: Text("${index + 1}"),
                  title: Text(question.questionText),
                  children: [
                    ...List.generate(
                      question.answers.length,
                      (index2) {
                        return Text("${question.answers[index2]}");
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddQuestionDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}