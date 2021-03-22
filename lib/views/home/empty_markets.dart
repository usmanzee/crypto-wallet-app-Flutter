import 'package:flutter/material.dart';

class EmptyMarkets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60.0,
        ),
        Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      "assets/ilustration/noData.png",
                      height: 105.0,
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "No Data",
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontFamily: "Sans",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0),
                )
              ]),
        ),
      ],
    );
  }
}
