import 'package:badl_app/modals/user.dart';
import 'package:badl_app/network/shared_pereference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Network {
  static final instance = FirebaseFirestore.instance;
  static final reports = instance.collection('Reports');
  static final doctors = instance.collection('Doctors');

  // add report
  static Future<void> addReport(Map<String, dynamic> report) async {
    await reports.add(report).then(
      (value) async {
        String doctorName = await Local.getUserName();
        await reports.doc(value.id).update(
          {
            'reportId': value.id,
            'userName': doctorName,
          },
        );
      },
      onError: (error) => print("Failed to add user: $error"),
    );
  }

  // add user
  static Future<void> createUser(User user) async {
    await doctors
        .doc(user.uid)
        .set(
          user.toMap(),
        )
        .then(
          (_) {},
          onError: (error) => print("Failed to add user: $error"),
        );
  }

  // get the user info
  static Future<User> getUserInfo({required String uid}) async {
    return await doctors.doc(uid).get().then(
      (value) async {
        return User.fromMap(value.data()!);
      },
      onError: (error) => print("Failed to get user info: $error"),
    );
  }
}
