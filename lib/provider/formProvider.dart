import 'package:bakerstreet_assignment/model/personData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FormProvider with ChangeNotifier {
  var firebaseAuth = FirebaseAuth.instance.currentUser;

  final UserData _userData =
      UserData(name: "", email: "", age: 0, gender: "", dob: '');
  bool isLoading = false;

  Future addUserDetails(UserData user) async {
    isLoading = true;
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(firebaseAuth!.phoneNumber)
          .set(
        {
          'name': user.name,
          'email': user.email,
          'age': user.age,
          'dob': user.dob,
          'gender': user.gender,
        },
      ).then((value) async {
        isLoading = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Done");
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<UserData> getUserDetails() async {
    final collection = await FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth!.phoneNumber)
        .get();

    final userDetails = UserData(
        name: collection.get("name"),
        email: collection.get("email"),
        age: collection.get("age"),
        dob: collection.get("dob"),
        gender: collection.get("gender"));

    notifyListeners();
    return userDetails;
  }

  UserData get userDetails => _userData;
}
