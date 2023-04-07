import 'package:flutter/material.dart';

class TextFieldLableWidget extends StatelessWidget {
  String title;
  TextFieldLableWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 260),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
      ),
    );
  }
}
