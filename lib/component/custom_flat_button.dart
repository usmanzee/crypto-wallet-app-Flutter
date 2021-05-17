import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final String title;
  final TextStyle titleStyle;
  final ButtonStyle buttonStyle;
  final VoidCallback onPressed;

  CustomFlatButton(
      {this.title, this.titleStyle, this.buttonStyle, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: Text(
        title,
        style: titleStyle,
      ),
    );
  }
}
