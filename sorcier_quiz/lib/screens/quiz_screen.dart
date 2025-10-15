import 'package:flutter/material.dart';
import '../data/questions.dart';
import '../widgets/answer_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  final Map<String, int> scores = {
    "GPTaigle": 0,
    "Geminiard": 0,
    "Copilouffle": 0,
    "Llamador": 0,
  };

  void _answer(String house) {
    setState(() {
      scores[house] = (scores[house] ?? 0) + 1;

      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(scores: scores),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${currentQuestion + 1}/${questions.length}'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
              color: Colors.amberAccent,
              backgroundColor: Colors.white24,
            ),
            const SizedBox(height: 30),
            Text(
              question.text,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ...question.options.map(
              (opt) => AnswerButton(
                text: opt.text,
                onPressed: () => _answer(opt.house),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
