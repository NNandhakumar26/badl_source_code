import 'dart:convert';

class User {
  String Name;
  String uid;
  String Mail;
  String Contact;
  String Designation;
  String Address;
  User({
    required this.Name,
    required this.uid,
    required this.Mail,
    required this.Contact,
    required this.Designation,
    required this.Address,
  });

  User copyWith({
    String? Name,
    String? uid,
    String? Mail,
    String? Contact,
    String? Designation,
    String? Address,
  }) {
    return User(
      Name: Name ?? this.Name,
      uid: uid ?? this.uid,
      Mail: Mail ?? this.Mail,
      Contact: Contact ?? this.Contact,
      Designation: Designation ?? this.Designation,
      Address: Address ?? this.Address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': Name,
      'uid': uid,
      'Mail': Mail,
      'Contact': Contact,
      'Designation': Designation,
      'Address': Address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      Name: map['Name'] ?? '',
      uid: map['uid'] ?? '',
      Mail: map['Mail'] ?? '',
      Contact: map['Contact'] ?? '',
      Designation: map['Designation'] ?? '',
      Address: map['Address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(Name: $Name, uid: $uid, Mail: $Mail, Contact: $Contact, Designation: $Designation, Address: $Address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.Name == Name &&
        other.uid == uid &&
        other.Mail == Mail &&
        other.Contact == Contact &&
        other.Designation == Designation &&
        other.Address == Address;
  }

  @override
  int get hashCode {
    return Name.hashCode ^
        uid.hashCode ^
        Mail.hashCode ^
        Contact.hashCode ^
        Designation.hashCode ^
        Address.hashCode;
  }
}
