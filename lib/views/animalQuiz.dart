import 'package:flutter/material.dart';
import 'package:quiz_view/quiz_view.dart';

class AnimalQuiz extends StatefulWidget {
  @override
  _AnimalQuizState createState() => _AnimalQuizState();
}

class _AnimalQuizState extends State<AnimalQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: QuizView(
        image: Container(
          width: 150,
          height: 150,
          child: Image.network(
              "https://images.vexels.com/media/users/3/157222/isolated/preview/53798bcd7054e4feaef568a5cf49574b-etiqueta-de-pizza-by-vexels.png"),
        ),
        showCorrect: true,
        tagBackgroundColor: Colors.deepOrange,
        tagColor: Colors.black,
        answerColor: Colors.black,
        answerBackgroundColor: Color.fromARGB(255, 255, 0, 111),
        questionColor: Colors.black,
        backgroundColor: 
                      const Color(0xFFFFF176),
        width: 300,
        height: 600,
        question: "Queda sólo un trozo de pizza",
        rightAnswer: "Flutter",
        wrongAnswers: ["Fluttor", "Flitter"],
        onRightAnswer: () => print("Right"),
        onWrongAnswer: () => print("Wrong"),
      )),
    );
  }
}