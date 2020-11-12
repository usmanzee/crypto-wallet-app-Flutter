import 'package:flutter/material.dart';

class T3_deals extends StatefulWidget {
  T3_deals({Key key}) : super(key: key);

  _T3_dealsState createState() => _T3_dealsState();
}

class _T3_dealsState extends State<T3_deals> {
  @override
  Widget build(BuildContext context) {

    ///
    /// To measure the height of the device size
    ///
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: _height,
        child: ListView(
          children: <Widget>[
            card("assets/image/Template_3/deals_layout/buildingMenu.png",
                "Bank", "Get best promo"),
            card("assets/image/Template_3/deals_layout/cardMenu.png",
                "Credit Card", "Get best promo"),
            card("assets/image/Template_3/deals_layout/financeMenu.png", "Paid",
                "Get best promo"),
            card("assets/image/Template_3/deals_layout/findMenu.png", "Money",
                "Get best promo"),
            card("assets/image/Template_3/deals_layout/giveMenu.png", "Bonus",
                "Get best promo"),
            card("assets/image/Template_3/deals_layout/growthMenu.png",
                "Income", "Get best promo"),
            card("assets/image/Template_3/deals_layout/locationMenu.png",
                "Location", "Get best promo"),
            card("assets/image/Template_3/deals_layout/moneyMenu.png",
                "Exchange", "Get best promo"),
            card("assets/image/Template_3/deals_layout/saveMenu.png", "Exhange",
                "Get best promo"),
            card("assets/image/Template_3/deals_layout/shareMenu.png", "Plan",
                "Get best promo"),
            SizedBox(
              height: 450.0,
            )
          ],
        ),
      ),
    );
  }

  ///
  /// Card under of tab bar
  ///
  Widget card(String img, String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 120.0,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black12.withOpacity(0.1),
                  spreadRadius: 3.0),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontSize: 21.0,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                        color: Colors.black54,
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Container(
                width: 100.0,
                height: 80.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    image: DecorationImage(
                        image: AssetImage(img), fit: BoxFit.fill)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
