import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class T5_budget extends StatefulWidget {
  T5_budget({Key key}) : super(key: key);

  _T5_budgetState createState() => _T5_budgetState();
}

class _T5_budgetState extends State<T5_budget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),

      ///
      /// Appbar
      ///
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Budget",
          style: TextStyle(
              fontFamily: "Lemon",
              fontWeight: FontWeight.w400,
              fontSize: 15.0,
              color: Colors.black87),
        ),
        elevation: 0.2,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            _cardBudget(),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Create Box card budget
  ///
  Widget _cardBudget() {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15.0,
                  spreadRadius: 0.0)
            ]),
        child: Column(
          children: <Widget>[
            ///
            /// money spent top
            ///
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 45.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Spent so far",
                        style: TextStyle(
                            color: Colors.black54, fontFamily: "Popins"),
                      ),
                      Text(
                        "-\$420.00",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w800,
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 64.0,
                  width: 1.5,
                  color: Colors.black12.withOpacity(0.03),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 45.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Budgeted",
                        style: TextStyle(
                            color: Colors.black54, fontFamily: "Popins"),
                      ),
                      Text(
                        "\$1,000.00",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w800,
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _line(),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Keep spending your money",
              style: TextStyle(color: Colors.black54, fontFamily: "Popins"),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "\$40.86",
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Each day for me rest of the period",
              style: TextStyle(color: Colors.black54, fontFamily: "Popins"),
            ),

            ///
            /// Create line
            ///
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 3.0),
              child: new LinearPercentIndicator(
                width: _width - 50,
                lineHeight: 21.0,
                percent: 0.9,
                progressColor: Colors.greenAccent,
                center: Text("90%"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17.0, right: 17.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "November 2 2018",
                    style: TextStyle(color: Colors.black54, fontSize: 13.0),
                  ),
                  Text(
                    "December 1 2018",
                    style: TextStyle(color: Colors.black54, fontSize: 13.0),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            _line(),
            SizedBox(
              height: 20.0,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
                  child: Text(
                    "Cash flow so far",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0),
                  ),
                )),

            ///
            /// Create card cash flow
            ///
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _card(context, Color(0xFF3FCE98), Color(0xFF76EE93), "Spent",
                    "+\$400", "Income this month"),
                _card(context, Color(0xFFF179A7), Color(0xFFFFA1AB), "Earned",
                    "-\$680", "Expanses this month"),
                _card(context, Color(0xFF20BFF6), Color(0xFF1F9BE9),
                    "Worst Day", "-\$121", "Expanses this month"),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            _line(),
            SizedBox(
              height: 15.0,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15.0, left: 15.0, top: 5.0),
                  child: Text(
                    "Budget on categories",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0),
                  ),
                )),

            ///
            /// Create Linear percent indicator
            ///
            _budgetCategories("House Rent", "-\$300.00", 0.6, Colors.lightBlue),
            _budgetCategories("Shopping", "-\$100.00", 0.3, Colors.greenAccent),
            _budgetCategories(
                "Education", "-\$150.00", 0.4, Colors.orangeAccent),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  ///
  /// Create budget categories
  ///
  Widget _budgetCategories(
    String _title,
    String _value,
    double _percent,
    Color _lineColor,
  ) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 15.0,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _title,
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Sans"),
              ),
              Text(
                _value,
                style:
                    TextStyle(color: _lineColor, fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          LinearPercentIndicator(
            width: _width - 50.0,
            lineHeight: 10.0,
            percent: _percent,
            progressColor: _lineColor,
          ),
        ],
      ),
    );
  }

  ///
  /// Create card cash flow
  ///
  Widget _card(BuildContext ctx, Color _color1, Color _color2, String _title,
      String _value, String _ket) {
    double _width = MediaQuery.of(ctx).size.width;
    return Padding(
      padding: const EdgeInsets.only(right: 7.0, left: 7.0),
      child: Container(
        height: 70.0,
        width: _width / 3.69,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              _color1,
              _color2,
            ]),
            boxShadow: [
              BoxShadow(
                  offset: Offset(6, 7),
                  color: _color1.withOpacity(0.45),
                  blurRadius: 5.0,
                  spreadRadius: 1.0)
            ],
            borderRadius: BorderRadius.all(Radius.circular(7.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Sans"),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              _value,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.0,
                  fontFamily: "Popins",
                  letterSpacing: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Custom line
  ///
  Widget _line() {
    return Container(
      height: 1.5,
      width: double.infinity,
      color: Colors.black12.withOpacity(0.03),
    );
  }
}
