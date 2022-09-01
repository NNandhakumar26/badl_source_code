import 'package:badl_app/modals/condition.dart';
import 'package:badl_app/modals/preference.dart';

import 'heading.dart';

class QuestionSet {
  Heading? heading;
  List<Preference> preferences;
  Criteria? criteria;

  QuestionSet({this.heading, required this.preferences, this.criteria});

  Map<String, dynamic> toMap() {
    return {
      'heading': heading,
      'preferences': preferences,
    };
  }

  factory QuestionSet.fromJson(Map<String, dynamic> json) => QuestionSet(
        heading: Heading.fromJson(json['heading']),
        preferences: List<Preference>.from(
            json['preferences'].map((x) => Preference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'heading': heading!.toJson(),
        'preferences': List<dynamic>.from(preferences.map((x) => x.toJson())),
      };

  @override
  String toString() =>
      'QuestionSet(heading: $heading, preferences: $preferences, criteria: $criteria)';
}
