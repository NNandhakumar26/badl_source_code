class Diagnosis {
  String id;
  String question;
  bool isTrue;
  Set<String>? listOfQuestions;

  Diagnosis({
    required this.id,
    required this.question,
    this.isTrue = false,
    this.listOfQuestions,
  });
}
