import 'package:flutter/material.dart';

class T2_Investment extends StatefulWidget {
  T2_Investment({Key key}) : super(key: key);

  _T2_InvestmentState createState() => _T2_InvestmentState();
}

class _T2_InvestmentState extends State<T2_Investment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF313237),

      ///
      /// Appbar
      ///
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Color(0xFF313237),
        centerTitle: true,
        title: Text(
          "Select Investment",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Sans",
              fontSize: 17.0,
              fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            _card(Icons.polymer, "Cautious",
                "For starters, we recommend the ABF Bond Index ETF, which gives an averange annual return of 4.3%"),
            _card(Icons.redeem, "Balanced",
                "Comfortable taking a bit more risk? STI ETF which gives an average annual return of 6.7%"),
            _card(Icons.atm, "Adventurous",
                "If growth is a high priority for you, we recommend the ABC unit trust which gives an average")
          ],
        ),
      ),
    );
  }


  ///
  /// Widget for card
  ///
  Widget _card(IconData _icon, String _title, String _desc) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 15.0, left: 15.0, right: 15.0, bottom: 5.0),
      child: InkWell(
        onTap: () {
          // Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___)=> new icoDetail()));
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Color(0xFF363940),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 170.0,
                width: 4.0,
                decoration: BoxDecoration(
                    color: Color(0xFF15EDED),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 65.0),
                child: Icon(
                  _icon,
                  color: Colors.white54,
                  size: 30.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Container(
                  width: 250.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _title,
                        style: TextStyle(
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w800,
                            fontSize: 16.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 15.0),
                        child: Text(
                          _desc,
                          style: TextStyle(
                              color: Colors.white54,
                              fontFamily: "Popins",
                              fontSize: 13.5),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
