import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final ValueChanged onChanged;
  final FormFieldValidator validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscure;
  final String icon;
  final TextAlign textAlign;
  final Widget widgetIcon;

  CustomTextField(
      {this.label,
      this.hint,
      this.onChanged,
      this.validator,
      this.controller,
      this.keyboardType,
      this.obscure,
      this.icon,
      this.textAlign,
      this.widgetIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: TextFormField(
            onChanged: onChanged,
            // onSaved: onSaved,
            style: new TextStyle(color: Colors.white),
            textAlign: textAlign,
            obscureText: obscure,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            autocorrect: false,
            autofocus: false,
            decoration: InputDecoration(
                errorStyle: TextStyle(
                  fontSize: 13.5,
                ),
                errorMaxLines: 3,
                filled: true,
                fillColor: Colors.transparent,
                labelText: label,
                hintText: hint,
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(
                  color: Colors.white70,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
        ),
      ],
    );
  }
}
