import 'dart:async';
import 'package:bakerstreet_assignment/pages/homeScreen.dart';
import 'package:bakerstreet_assignment/pages/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 50), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Center(
        child: SizedBox(
          height: 80,
          width: 80,
          child: Image.asset(
            "assets/png/check.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
