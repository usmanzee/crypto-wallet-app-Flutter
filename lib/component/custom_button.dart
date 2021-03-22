import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final Color splashColor;
  final Color disabledColor;
  final Color disabledTextColor;
  final Padding padding;
  final bool disabled;
  final Function onPressed;

  CustomButton(
      {this.label,
      this.height,
      this.width,
      this.color,
      this.textColor,
      this.splashColor,
      this.disabledColor,
      this.disabledTextColor,
      this.padding,
      this.disabled,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: MaterialButton(
            height: height,
            minWidth: width,
            color: color,
            disabledColor: disabledColor,
            disabledTextColor: disabledTextColor,
            textColor: textColor,
            child: Text(
              label,
            ),
            onPressed: disabled ? null : onPressed,
            splashColor: splashColor,
            // shape: RoundedRectangleBorder(
            //     side: BorderSide(
            //         color: Colors.blue, width: 1, style: BorderStyle.solid),
            //     borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ],
    );
  }
}
