import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/platform/platform_io.dart';

class PatientDetails {
  String? userID;
  int age;
  int? months;
  String gender;
  String? diagnosis;
  bool? anyOrthosesOrProstheses;
  String? nameOfTheDevice;

  PatientDetails({
    this.userID,
    required this.age,
    this.months,
    required this.gender,
    this.diagnosis,
    this.anyOrthosesOrProstheses,
    this.nameOfTheDevice,
  });

  Map<String, dynamic> toJson() => {
        'uid': userID,
        'age': age,
        'months': months ?? '',
        'gender': gender,
        'diagnosis': diagnosis,
        'OrthosesOrProthese': anyOrthosesOrProstheses,
        'NameOfTheDevice': nameOfTheDevice,
      };

  @override
  String toString() =>
      'UID: $userID, Age : $age, Months : $months, Gender : $gender, diagnosis :$diagnosis, Othoses: $anyOrthosesOrProstheses, name of Device: $nameOfTheDevice,';
}
