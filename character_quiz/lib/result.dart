import 'dart:ui';

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int finalScore;
  final Function resetHandler;

  Result(this.finalScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (finalScore <= 9) {
      resultText = 'You are awesome';
    } else if (finalScore <= 13) {
      resultText = 'Pretty likeable';
    } else if (finalScore <= 15) {
      resultText = 'You are strange';
    } else {
      resultText = 'You are so bad';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: <Widget>[
            Text(
              resultPhrase,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            FlatButton(onPressed: resetHandler, child: Text('Restart Quiz!!!'), textColor: Colors.blue,)
          ],
    ));
  }
}
