import 'package:character_quiz/result.dart';
import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  static const _questions = [
    {
      'question': 'what\'s your favorite color?',
      'answers': [
        {'text': 'blue', 'score': 5},
        {'text': 'red', 'score': 8},
        {'text': 'green', 'score': 3}
      ]
    },
    {
      'question': 'what\'s your favorite animal?',
      'answers': [
        {'text': 'rabbit', 'score': 6},
        {'text': 'tiger', 'score': 1},
        {'text': 'cat', 'score': 5}
      ]
    },
    {
      'question': 'what\'s your favorite food?',
      'answers': [
        {'text': 'maggi', 'score': 2},
        {'text': 'noodles', 'score': 1},
        {'text': 'rice', 'score': 10}
      ]
    },
  ];

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex += 1;
    });
    print("Answer question");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Character Quiz"),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(_questions, _answerQuestion, _questionIndex)
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
