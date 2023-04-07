import 'package:bakerstreet_assignment/pages/homeScreen.dart';
import 'package:bakerstreet_assignment/pages/otpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String _verificationId;

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          Navigator.of(context).push(MaterialPageRoute(builder: (contex) {
            return OtpScreen(phoneNumber: phoneNumber);
          }));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithPhoneNumber(
      String smsCode, BuildContext context) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (contex) {
        return const HomePage();
      }));
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  notifyListeners();
}
