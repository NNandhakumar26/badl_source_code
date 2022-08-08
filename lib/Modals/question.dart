class Question {
  String id;
  String question;
  String? option;
  //to calculate the score based on the option selected

  Question({
    required this.id,
    required this.question,
    this.option = '',
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        option: json["option"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "option": option,
      };
}
