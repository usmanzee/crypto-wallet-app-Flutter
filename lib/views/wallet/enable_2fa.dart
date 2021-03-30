import 'package:flutter/material.dart';

class Enable2FA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          title: Text(
            'Enable 2FA',
            style: TextStyle(
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5),
          ),
          iconTheme: IconThemeData(
              color: Theme.of(context).textSelectionTheme.selectionColor),
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Column(children: <Widget>[]));
  }
}
