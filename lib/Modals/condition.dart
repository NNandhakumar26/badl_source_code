class Criteria {
  String parameter;
  Map<String, List<int>> valueIDs;

  Criteria({
    required this.parameter,
    required this.valueIDs,
  });
}


// // To parse this JSON data, do
// //
// //     final criteria = criteriaFromJson(jsonString);

// import 'dart:convert';

// Criteria criteriaFromJson(String str) => Criteria.fromJson(json.decode(str));

// String criteriaToJson(Criteria data) => json.encode(data.toJson());

// class Criteria {
//     Criteria({
//         this.parameter,
//         this.values,
//     });

//     String parameter;
//     Values values;

//     factory Criteria.fromJson(Map<String, dynamic> json) => Criteria(
//         parameter: json["parameter"],
//         values: Values.fromJson(json["values"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "parameter": parameter,
//         "values": values.toJson(),
//     };
// }

// class Values {
//     Values({
//         this.value1,
//     });

//     List<int> value1;

//     factory Values.fromJson(Map<String, dynamic> json) => Values(
//         value1: List<int>.from(json["value1"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "value1": List<dynamic>.from(value1.map((x) => x)),
//     };
// }
