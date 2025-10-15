class Question {
  final String text;
  final List<AnswerOption> options;

  Question({required this.text, required this.options});
}

class AnswerOption {
  final String text;
  final String house;

  AnswerOption({required this.text, required this.house});
}
