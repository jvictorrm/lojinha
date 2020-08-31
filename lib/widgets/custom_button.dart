import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final bool isActivated;
  final String text;
  final Function onPressed;
  final Color backgroundColor;
  final Color textColor;

  CustomButton(this.text, this.onPressed,
      {this.isActivated = true,
      this.backgroundColor,
      this.textColor = Colors.white});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 45.0,
        child: RaisedButton(
            color: widget.backgroundColor == null
                ? Theme.of(context).primaryColor
                : widget.backgroundColor,
            child: Text(widget.text,
                style: TextStyle(
                    fontSize: 20.0,
                    color: !widget.isActivated
                        ? Theme.of(context).primaryColor
                        : widget.textColor)),
            onPressed: !widget.isActivated ? null : widget.onPressed));
  }
}
