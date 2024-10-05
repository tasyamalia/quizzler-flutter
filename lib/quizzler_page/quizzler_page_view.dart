import 'package:flutter/material.dart';
import 'package:quizzler_flutter/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizzlerPageView extends StatefulWidget {
  const QuizzlerPageView({super.key});

  @override
  State<QuizzlerPageView> createState() => _QuizzlerPageViewState();
}

class _QuizzlerPageViewState extends State<QuizzlerPageView> {
  List<Widget> scoreKeeper = [];
  QuizBrain quizBrain = QuizBrain();

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        quizBrain.reset();

        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(
            const Icon(Icons.close, color: Colors.red),
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              )),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            color: Colors.green,
            child: TextButton(
                onPressed: () {
                  checkAnswer(true);
                },
                child: const Text(
                  "True",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            color: Colors.red,
            child: TextButton(
                onPressed: () {
                  checkAnswer(false);
                },
                child: const Text(
                  "False",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ),
        )),
        scoreKeeper.isNotEmpty
            ? Row(children: scoreKeeper)
            : const SizedBox(
                height: 24,
              )
      ],
    );
  }
}
