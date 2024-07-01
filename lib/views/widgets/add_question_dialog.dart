import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/utils/extensions.dart';
import 'package:quiz/views/widgets/app_textformfield.dart';

import '../../controllers/quiz_controller.dart';

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
      scrollable: true,
      title: const Text("Add question"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextFormField(
              controller: questionController,
              label: 'Enter question',
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter question";
                }
                return null;
              },
            ),
            10.height,
            AppTextFormField(
              controller: answerAController,
              label: 'Enter answer A',
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter answer A";
                }
                return null;
              },
            ),
            10.height,
            AppTextFormField(
              controller: answerBController,
              label: 'Enter answer B',
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter answer B";
                }
                return null;
              },
            ),
            10.height,
            AppTextFormField(
              controller: answerCController,
              label: 'Enter answer C',
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter answer C";
                }
                return null;
              },
            ),
            10.height,
            AppTextFormField(
              controller: correctAnswerController,
              label: "Enter correct answer variant",
              isLast: true,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter correct answer variant";
                } else if (value != "A" || value != "B" || value != "C") {
                  return "Enter only 'A' or 'B' or 'C'";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<QuizController>().addQuestion(
                    question: Question(
                      id: UniqueKey().toString(),
                      questionText: questionController.text,
                      answers: [
                        {"A": answerAController.text},
                        {"B": answerBController.text},
                        {"C": answerCController.text},
                      ],
                      correctVariant: correctAnswerController.text,
                    ),
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
