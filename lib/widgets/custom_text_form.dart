import 'package:flutter/material.dart';

class CustomTextForm extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;

  CustomTextForm(
      {@required this.label,
      @required this.controller,
      this.obscureText = false,
      this.keyboardType = TextInputType.text});

  @override
  _CustomTextFormState createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      cursorColor: Colors.white,
    );
  }
}
