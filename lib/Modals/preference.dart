// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

String preferencesToJson(List<Preference> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Preference {
  int? id;
  bool isSelected;
  String? question;
  List<Component>? components;
  List<SubComponent>? subComponents;

  Preference({
    this.id,
    this.isSelected = true,
    this.question,
    this.components,
    this.subComponents,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'components': components,
      'subComponents': subComponents,
    };
  }

  factory Preference.fromJson(Map<String, dynamic> json) => Preference(
        id: json["id"],
        question: json["question"],
        components: List<Component>.from(
            json["components"].map((x) => Component.fromJson(x))),
        subComponents: List<SubComponent>.from(
            json["subComponents"].map((x) => SubComponent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question == null ? null : question,
        "components": components == null
            ? null
            : List<dynamic>.from(components!.map((x) => x.toJson())),
        "subComponents": subComponents == null
            ? null
            : List<dynamic>.from(subComponents!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'Preference(id: $id, question: $question, components: $components, subComponents: $subComponents)';
  }
}

class Scoring {
  double? total;
  int dependent;
  int partiallyDependent;
  int independent;
  // int? notApplicable;

  Scoring({
    this.total,
    this.dependent = 0,
    this.partiallyDependent = 0,
    this.independent = 0,
    // this.notApplicable = 0,
  });

  double get relativeDependent => 0.0;

  int get totalCount => dependent + independent + partiallyDependent;
  double get dependentPercent => (dependent / totalCount) * 100;
  double get independentPercent => (independent / totalCount) * 100;
  double get partialPercent => (partialPercent / totalCount) * 100;

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'dependent': dependent,
      'partiallyDependent': partiallyDependent,
      'independent': independent,
    };
  }

  factory Scoring.fromJson(Map<String, dynamic> json) => Scoring(
        total: json["total"],
        dependent: json["dependent"],
        partiallyDependent: json["partiallyDependent"],
        independent: json["independent"],
        // notApplicable: json["notApplicable"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "dependent": dependent,
        "partiallyDependent": partiallyDependent,
        "independent": independent,
        // "notApplicable": notApplicable,
      };

  @override
  String toString() {
    return 'Scoring(total: $total, dependent: $dependent, partiallyDependent: $partiallyDependent, independent: $independent)';
  }
}

class Component {
  int? id;
  String? value;
  bool isChecked;
  Component({this.id, this.value, this.isChecked = false});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "value": value,
      "isChecked": isChecked,
    };
  }

  factory Component.fromJson(Map<String, dynamic> json) => Component(
        id: json["id"],
        value: json["value"],
        isChecked: json["isChecked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "isChecked": isChecked,
      };

  @override
  String toString() {
    return '${id} is id, $value is value, $isChecked is checked';
  }
}

class SubComponent {
  List<int>? ids;
  String? value;
  String? response;
  int minAge;
  int maxAge;
  //Null represents  applicable for both male and female
  bool? isMale;

  SubComponent({
    this.ids,
    this.value,
    this.response,
    this.minAge = 0,
    this.maxAge = 100,
    this.isMale = null,
  });

  SubComponent copyWith({
    List<int>? ids,
    String? value,
    String? response,
    int? minAge,
    int? maxAge,
    bool? isMale,
  }) {
    return SubComponent(
      ids: ids ?? this.ids,
      value: value ?? this.value,
      response: response ?? this.response,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      isMale: isMale ?? this.isMale,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ids': ids,
      'value': value,
      'response': response,
      'minAge': minAge,
      'maxAge': maxAge,
      'isMale': isMale,
    };
  }

  factory SubComponent.fromMap(Map<String, dynamic> map) {
    return SubComponent(
      ids: List<int>.from(map['ids']),
      value: map['value'],
      response: map['response'],
      minAge: map['minAge']?.toInt(),
      maxAge: map['maxAge']?.toInt(),
      isMale: map['isMale'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubComponent.fromJson(String source) =>
      SubComponent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubComponent(ids: $ids, value: $value, response: $response, minAge: $minAge, maxAge: $maxAge, isMale: $isMale)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubComponent &&
        listEquals(other.ids, ids) &&
        other.value == value &&
        other.response == response &&
        other.minAge == minAge &&
        other.maxAge == maxAge &&
        other.isMale == isMale;
  }

  @override
  int get hashCode {
    return ids.hashCode ^
        value.hashCode ^
        response.hashCode ^
        minAge.hashCode ^
        maxAge.hashCode ^
        isMale.hashCode;
  }
}
