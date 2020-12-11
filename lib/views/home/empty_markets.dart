import 'package:flutter/material.dart';

class EmptyMarkets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
      child: Center(
        child: Text(
          'No Result',
          textAlign: TextAlign.center,
        ),
      ),
    ));
  }
}
