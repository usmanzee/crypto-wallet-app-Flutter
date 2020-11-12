import 'package:crypto_template/screen/AnotherTemplate/Template1/T1_bottomNavBar.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template2/T2_home.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template3/T3_Dashboard.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template3/T3_home.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template4/T4_Dashboard.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template5/T5_bottomNavBar.dart';
import 'package:flutter/material.dart';

class seeAllTemplate extends StatefulWidget {
  final Widget child;

  seeAllTemplate({Key key, this.child}) : super(key: key);

  _seeAllTemplateState createState() => _seeAllTemplateState();
}

class _seeAllTemplateState extends State<seeAllTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        elevation: 0.2,
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "See All Template",
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Popins",
              fontSize: 17.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new T1_bottomNav()));
                },
                child: card([Color(0xFF15EDED), Color(0xFF029CF5)],
                    Color(0xFF15EDED), "Template 1")),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new T2_home()));
                },
                child: card([Color(0xFF15EDED), Color(0xFF029CF5)],
                    Color(0xFF15EDED), "Template 2")),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => T3_Dashboard()));
                },
                child: card([Color(0xFF15EDED), Color(0xFF029CF5)],
                    Color(0xFF15EDED), "Template 3")),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => T4_dashboard()));
                },
                child: card([Color(0xFF15EDED), Color(0xFF029CF5)],
                    Color(0xFF15EDED), "Template 4")),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => T5_bottomNavBar()));
                },
                child: card([Color(0xFF15EDED), Color(0xFF029CF5)],
                    Color(0xFF15EDED), "Template 5")),
            SizedBox(
              height: 30.0,
            )
          ],
        ),
      ),
    );
  }

  Widget card(List<Color> _colorGradient, Color _colorShadow, String _title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 15.0),
      child: Container(
        height: 120.0,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _colorGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                  color: _colorShadow.withOpacity(0.2),
                  blurRadius: 20.0,
                  spreadRadius: 0.1,
                  offset: Offset(3, 10))
            ]),
        child: Center(
          child: Text(
            _title,
            style: TextStyle(
                fontFamily: "Berlin", fontSize: 22.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
