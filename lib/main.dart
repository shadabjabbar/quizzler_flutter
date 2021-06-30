import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './questionbooklet.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: Text(
            'Quizzler',
          ),
          centerTitle: true,
          backgroundColor: Colors.grey.shade800,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  int questionNumber = 0;
  int score = 0;
  void selectedOption(bool userOption) {
    if (userOption == questionBooklet().questions[questionNumber].answer)
      score++;
    print(score);
    setState(() {
      questionNumber++;
      if (userOption) {
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      if (questionNumber == questionBooklet().questions.length) {
        questionNumber = 0;
        scoreKeeper.clear();
        Alert(
          context: context,
          title: "Quiz Completed",
          desc:
              "You got $score out of ${questionBooklet().questions.length}. Click to reset the Quiz.",
          buttons: [
            DialogButton(
              child: Text(
                "Reset",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        score = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBooklet().questions[questionNumber].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: FlatButton(
              color: Colors.green,
              onPressed: () {
                selectedOption(true);
              },
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: FlatButton(
              color: Colors.red,
              onPressed: () {
                selectedOption(false);
              },
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
