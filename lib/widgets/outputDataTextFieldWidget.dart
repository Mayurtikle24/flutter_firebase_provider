// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutputDataTextWidget extends StatelessWidget {
  String name;
  String email;
  int age;
  String dob;
  String gender;

  OutputDataTextWidget({
    Key? key,
    required this.name,
    required this.email,
    required this.age,
    required this.dob,
    required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name: ${name}",
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(181, 0, 0, 0),
              )),
          const SizedBox(height: 5),
          Text("Email: ${email}",
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(181, 0, 0, 0),
              )),
          const SizedBox(height: 5),
          Text("Age: ${age}",
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(181, 0, 0, 0),
              )),
          const SizedBox(height: 5),
          Text("Dob: ${dob}",
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(181, 0, 0, 0),
              )),
          const SizedBox(height: 5),
          Text("Gender: ${gender}",
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(181, 0, 0, 0),
              )),
        ],
      ),
    );
  }
}
