import 'package:badl_app/Modals/preference.dart';
import 'dart:convert';

Heading headingFromJson(String str) => Heading.fromJson(json.decode(str));
String headingToJson(Heading data) => json.encode(data.toJson());

class Heading {
  String? question;
  Scoring? scoring;
  Heading({this.question, this.scoring});

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'scoring': scoring,
    };
  }

  factory Heading.fromJson(Map<String, dynamic> json) => Heading(
        question: json["question"],
        scoring: Scoring.fromJson(json["scoring"]),
      );

  Map<String, dynamic> toJson() => {
        if (question != null) "question": question,
        if (scoring != null) "scoring": scoring!.toJson(),
      };
}
