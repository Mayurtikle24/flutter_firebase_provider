import 'package:bakerstreet_assignment/helper/colors.dart';
import 'package:flutter/material.dart';

class LoginFooterDesignWidger extends StatelessWidget {
  const LoginFooterDesignWidger({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: yellow, borderRadius: BorderRadius.circular(30)),
        ),
        const SizedBox(width: 5),
        Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
              color: lightPink,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80),
                  bottomLeft: Radius.circular(80))),
        ),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: lightpurple, borderRadius: BorderRadius.circular(100)),
        ),
      ],
    );
  }
}
