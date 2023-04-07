import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountTextWidget extends StatelessWidget {
  const AccountTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Haven't an account yet?",
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Text(
            "Create one",
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
