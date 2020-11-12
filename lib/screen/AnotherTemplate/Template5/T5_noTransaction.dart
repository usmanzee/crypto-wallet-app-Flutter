import 'package:flutter/material.dart';

class T5_noTransaction extends StatefulWidget {
  T5_noTransaction({Key key}) : super(key: key);

  _T5_noTransactionState createState() => _T5_noTransactionState();
}

class _T5_noTransactionState extends State<T5_noTransaction> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Container(
          height: _height - 170,
          width: double.infinity,
          child: ListView(
            children: <Widget>[_transaction()],
          ),
        ),
      ),
    );
  }

  ///
  /// Box don't have transaction
  ///
  Widget _transaction() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15.0,
                  spreadRadius: 0.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 15.0, bottom: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text(
                "You don't have any transaction \nright now, but you can",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.0,
              ),
              Image.asset(
                "assets/image/Template_5/noTransaction.png",
                height: 250.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Start adding one by pressing\n the plus icon from the bottom menu",
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
