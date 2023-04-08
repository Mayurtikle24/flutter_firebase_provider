import 'package:bakerstreet_assignment/helper/colors.dart';
import 'package:bakerstreet_assignment/widgets/accountTextWidget.dart';
import 'package:bakerstreet_assignment/widgets/loginFooterDesign.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/phoneAuthProvider.dart';
import 'otpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phone = "";
  final _phoneTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool validatePhone(String phone) {
    RegExp regExp = RegExp(
      r"^(?:[+0]9)?[0-9]{10}$",
    );
    if (!regExp.hasMatch(phone)) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    _phoneTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PhoneProvider phoneAuthProvider = Provider.of<PhoneProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  color: lightpurple,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(80),
                      bottomLeft: Radius.circular(80))),
            ),
            const SizedBox(height: 40),
            titleHeadingWidget(),
            const SizedBox(height: 30),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: lightPink,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Phone number",
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 21,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 25),
                    Form(
                      key: _formKey,
                      child: Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 70,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                            controller: _phoneTextController,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (phone) {
                              if (phone!.isEmpty) {
                                return 'Please enter your Number';
                              }
                              if (!validatePhone(phone)) {
                                return 'Please enter a valid Number';
                              }
                              return null;
                            },
                            autofillHints: const [
                              AutofillHints.telephoneNumber
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 2.0)),
                              prefixIcon: const Icon(
                                Icons.phone_android,
                                color: Colors.black,
                              ),
                              focusColor: Colors.black,
                              hintText: "Phone Number",
                              errorStyle: const TextStyle(height: 1),
                              labelStyle:
                                  const TextStyle(fontFamily: "Circular"),
                            )),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (contex) {
                            return OtpScreen(
                                phoneNumber: _phoneTextController.text.trim());
                          }));
                          phoneAuthProvider.verifyPhoneNumber(
                              "+91${_phoneTextController.text.trim()}",
                              context);
                        }
                      },
                      child: buttonContainerWidget("Request OTP"),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const AccountTextWidget(),
            const SizedBox(height: 45),
            const LoginFooterDesignWidger()
          ]),
        ),
      ),
    );
  }

  Widget buttonContainerWidget(String title) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(color: yellow, borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.playfairDisplay(
              fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget titleHeadingWidget() {
    return Column(
      children: [
        Text(
          "Let's Sign In you in",
          style: GoogleFonts.playfairDisplay(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Welcome back,\nYou've been missed!",
            style: GoogleFonts.playfairDisplay(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
