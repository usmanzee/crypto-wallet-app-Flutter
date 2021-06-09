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
  final int maxLines;
  final int maxLength;
  final TextInputAction textInputAction;
  final Widget suffix;
  final Widget prefix;

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
      this.widgetIcon,
      this.maxLines,
      this.maxLength,
      this.textInputAction,
      this.prefix,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: TextFormField(
            onChanged: onChanged,
            // onSaved: onSaved,
            style: new TextStyle(
                color: Theme.of(context).textSelectionTheme.selectionColor),
            textAlign: textAlign,
            obscureText: obscure,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            autocorrect: false,
            autofocus: false,
            textInputAction: textInputAction,
            // maxLines: maxLines,
            // maxLength: maxLength,
            decoration: InputDecoration(
                prefix: prefix,
                suffixIcon: suffix,
                errorStyle: TextStyle(
                  fontSize: 13.5,
                ),
                errorMaxLines: 3,
                filled: true,
                fillColor: Colors.transparent,
                labelText: label,
                hintText: hint,

                /* hintStyle: TextStyle(color: colorStyle.fontColorDarkTitle),
                labelStyle: TextStyle(
                  color: colorStyle.fontColorDarkTitle,
                ), */
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
        ),
      ],
    );
  }
}
