import 'package:bakerstreet_assignment/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../provider/phoneAuthProvider.dart';

class OtpScreen extends StatefulWidget {
  String phoneNumber;
  OtpScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var _pinController = new TextEditingController();
  var pinCode = "";

  @override
  void dispose() {
    super.dispose();
    _pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PhoneProvider _phoneAuthProvider = Provider.of<PhoneProvider>(context);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20, color: lightblue, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 20, top: 40),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              const SizedBox(height: 20),
              Lottie.asset('assets/lottie/otp.json',
                  height: 350, width: MediaQuery.of(context).size.width),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Enter your Code",
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                    "please enter the 6 digit verification code sent\nto +${widget.phoneNumber}",
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    )),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Material(
                  child: Pinput(
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    length: 6,
                    onChanged: (value) {
                      pinCode = value;
                    },
                    validator: (s) {
                      return s == pinCode ? null : 'Pin is incorrect';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _phoneAuthProvider.signInWithPhoneNumber(pinCode, context);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10, left: 20),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: yellow, borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          decoration: TextDecoration.none,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
