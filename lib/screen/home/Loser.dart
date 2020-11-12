import 'dart:async';

import 'package:crypto_template/component/loserModel.dart';
import 'package:crypto_template/screen/home/detailCrypto/loserDetail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class loser extends StatefulWidget {
  final Widget child;

  loser({Key key, this.child}) : super(key: key);

  _loserState createState() => _loserState();
}

class _loserState extends State<loser> {
  ///
  /// Get image data dummy from firebase server
  ///
  var imageNetwork = NetworkImage(
      "https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Screenshot_20181005-213938.png?alt=media&token=8c1abb09-4acf-45cf-9383-2f94d93f4ec9");

  ///
  /// check the condition is right or wrong for image loaded or no
  ///
  bool loadImage = true;

  
  @override
  void initState() {
    
  Timer(Duration(seconds: 3),(){
setState(() {
  loadImage=false;
});
    });
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 0.0, right: 0.0, top: 7.0, bottom: 7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Container(
                      width: 100.0,
                      child: Text(
                        "Pair",
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: "Popins"),
                      )),
                ),
                Container(
                    width: 100.0,
                    child: Text(
                      "Last Price",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    )),
                Container(
                    width: 80.0,
                    child: Text(
                      "24h Chg%",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    )),
              ],
            ),
          ),
        ),

        ///
        ///
        /// check the condition if image data from server firebase loaded or no
        /// if image loaded true (image still downloading from server)
        /// Card to set card loading animation
        ///

        loadImage ? _loadingImageAnimation(context) : _imageLoaded(context),
      ],
    );
  }
}

Widget listPriceloser(losers item, BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, top: 20.0),
    child: InkWell(
      onTap: () {
        Navigator.of(ctx).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new loserDetail(
                  item: item,
                )));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.pair,
                  style: TextStyle(fontFamily: "Popins", fontSize: 16.5),
                ),
                Text(
                  " / BTC",
                  style: TextStyle(
                      fontFamily: "Popins",
                      fontSize: 11.5,
                      color: Theme.of(ctx).hintColor),
                )
              ],
            ),
          ),
          Container(
            width: 100.0,
            child: Text(
              item.lastPrice,
              style: TextStyle(fontFamily: "Popins", fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
                width: 80.0,
                height: 35.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  color: Colors.redAccent,
                ),
                child: Center(
                    child: Text(
                  item.chg,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ))),
          )
        ],
      ),
    ),
  );
}

Widget loadingListPriceloser(losers item, BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, top: 17.0),
    child: Shimmer.fromColors(
      baseColor: Color(0xFF3B4659),
      highlightColor: Color(0xFF606B78),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 70.0,
            height: 17.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Theme.of(ctx).hintColor,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Theme.of(ctx).hintColor,
              ),
              height: 20.0,
              width: 70.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Theme.of(ctx).hintColor,
              ),
              height: 20.0,
              width: 115.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              color: Theme.of(ctx).hintColor,
              width: 80.0,
              height: 35.0,
            ),
          )
        ],
      ),
    ),
  );
}

///
///
/// Calling imageLoading animation for set a grid layout
///
///
Widget _loadingImageAnimation(BuildContext context) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: losersList.length,
      itemBuilder: (ctx, i) {
        return loadingListPriceloser(losersList[i], ctx);
      },
    ),
  );
}

///
///
/// Calling ImageLoaded animation for set a grid layout
///
///
Widget _imageLoaded(BuildContext context) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: losersList.length,
      itemBuilder: (ctx, i) {
        return listPriceloser(losersList[i], ctx);
      },
    ),
  );
}
