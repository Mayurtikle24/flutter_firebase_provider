import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String name;
  final String email;
  final int age;
  final String dob;
  final String gender;
  UserData({
    required this.name,
    required this.email,
    required this.age,
    required this.dob,
    required this.gender,
  });

  toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'dob': dob,
      'gender': gender,
    };
  }

  factory UserData.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> element) {
    return UserData(
        name: element.get("name"),
        email: element.get("email"),
        age: element.get("age"),
        dob: element.get("dob"),
        gender: element.get("gender"));
  }
}
