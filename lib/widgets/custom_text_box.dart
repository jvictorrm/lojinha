import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final Widget content;

  CustomTextBox(this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.0),
        decoration: BoxDecoration(
            border: Border.fromBorderSide(
                BorderSide(width: 0.5, color: Colors.white))),
        child: this.content,
      ),
    );
  }
}
