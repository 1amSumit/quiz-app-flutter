import 'package:flutter/material.dart';
import "questionBank.dart";

QuestionBank questionBank = QuestionBank();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Quiz(),
          ),
        ),
      ),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentIndex = 0;
  bool answer = true;
  List<Icon> scoreCard = [];

  bool getUserAnswer(bool ans) {
    answer = ans;
    return ans;
  }

  bool isCorrect() {
    if (answer == questionBank.questions[currentIndex].questionAnswer) {
      return true;
    } else {
      return false;
    }
  }

  void getNextQuestion() {
    setState(() {
      bool userCorrect = isCorrect();
      if (userCorrect == true) {
        scoreCard.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreCard.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }

      if (currentIndex == questionBank.questions.length - 1) {
        currentIndex = 0;
      } else {
        currentIndex += 1;
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
          flex: 6,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                questionBank.questions[currentIndex].questionString,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: TextButton(
              child: Text(
                "True",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                getUserAnswer(true);
                getNextQuestion();
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: TextButton(
              onPressed: () {
                getUserAnswer(false);
                getNextQuestion();
              },
              child: Text(
                "False",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
          ),
        ),
        Row(
          children: scoreCard,
        ),
      ],
    );
  }
}
