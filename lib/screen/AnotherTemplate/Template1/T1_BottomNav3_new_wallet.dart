import 'package:crypto_template/screen/AnotherTemplate/Template1/T1_wallet_detail.dart';
import 'package:flutter/material.dart';

class T1_new_wallet extends StatefulWidget {
  @override
  _T1_new_walletState createState() => _T1_new_walletState();
}

class _T1_new_walletState extends State<T1_new_wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141C35),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  color: Color(0xFF222945),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/image/create_wallet.png",
                    height: 45.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Create new wallet",
                style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0),
              ),
              Text(
                "Which currency would you like to use?",
                style: TextStyle(
                    fontFamily: "Sans",
                    fontWeight: FontWeight.w300,
                    fontSize: 15.0,
                    color: Colors.white54),
              ),
              SizedBox(
                height: 50.0,
              ),
              _card("assets/image/crypto_icon/icon_bitcoin.png", "Bitcoin"),
              _card("assets/image/crypto_icon/icon_bee.png", "Dash"),
              _card("assets/image/crypto_icon/icon_elf.png", "Ripple"),
              _card("assets/image/crypto_icon/icon_eth.png", "Ethereum"),
              _card("assets/image/crypto_icon/icon_lnc.png", "Leterum"),
            ],
          ),
        ),
      ),
    );
  }

 
  ///
  /// Card for crypto list
  ///
  Widget _card(String img, title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => T1_wallet_detail()));
        },
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(70.0)),
                    color: Color(0xFF202840)),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontFamily: "Sans",
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w300),
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        tileMode: TileMode.repeated,
                        colors: [Color(0xFF15EDED), Color(0xFF029CF5)]),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  child: Center(
                      child: Image.asset(
                    img,
                    color: Colors.white,
                    height: 20.0,
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
