import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/controllers/quiz_controller.dart';

import '../models/question.dart';

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
                ),
              );
              /*ListTile(
                leading: Text("${index + 1}"),
                title: Text(question.questionText),
              )*/
              ;
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

class AddQuestionDialog extends StatelessWidget {
  AddQuestionDialog({super.key});

  final formKey = GlobalKey<FormState>();
  final questionController = TextEditingController();
  final answerAController = TextEditingController();
  final answerBController = TextEditingController();
  final answerCController = TextEditingController();
  final correctAnswerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add question"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: questionController,
              decoration: const InputDecoration(
                hintText: 'Enter question',
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter question";
                }
                return null;
              },
            ),
            TextFormField(
              controller: answerAController,
              decoration: const InputDecoration(
                hintText: 'Enter answer A',
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter answer A";
                }
                return null;
              },
            ),
            TextFormField(
              controller: answerBController,
              decoration: const InputDecoration(
                hintText: 'Enter answer B',
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter answer B";
                }
                return null;
              },
            ),
            TextFormField(
              controller: answerCController,
              decoration: const InputDecoration(
                hintText: 'Enter answer C',
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter answer C";
                }
                return null;
              },
            ),
            TextFormField(
              controller: correctAnswerController,
              decoration: const InputDecoration(
                hintText: 'Enter correct answer variant',
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter correct answer variant";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<QuizController>().addQuestion(
                    questionText: questionController.text,
                    answer1: answerAController.text,
                    answer2: answerBController.text,
                    answer3: answerCController.text,
                    correctVariant: correctAnswerController.text,
                  );
              questionController.clear();
              answerAController.clear();
              answerBController.clear();
              answerCController.clear();
              correctAnswerController.clear();
              Navigator.pop(context);
            }
          },
          child: const Text(
            "Add",
            style: TextStyle(color: Colors.teal),
          ),
        )
      ],
    );
  }
}
