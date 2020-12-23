import 'dart:math';
import 'package:crypto_font_icons/crypto_font_icon_data.dart';
import 'package:crypto_template/component/AssetsWallet/assetsModel.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:crypto_template/views/wallet/wallet_detail.dart';
import 'package:crypto_template/views/wallet/wallet_loading_animation.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math.dart' as Vector;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';

class Wallet extends StatelessWidget {
  final assetsWallet item;
  final walletController = Get.put(WalletController());
  Wallet({this.item}) {
    timeDilation = 1.0;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    Size size = new Size(MediaQuery.of(context).size.width, 200.0);
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 225.0),

            ///
            /// Create wallet list
            ///
            child: Obx(() {
              if (walletController.isLoading.value)
                return WalletLoadingAnimation(context: context);
              else
                return Container(
                    child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.only(top: 0.0),
                  itemBuilder: (ctx, i) {
                    return walletList(assetsWalletList[i],
                        walletController.walletsList[i], ctx);
                  },
                  itemCount: walletController.walletsList.length,
                ));
            }),
          ),
          Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  ///
                  /// Create wave header
                  ///
                  new WaveBody(
                      size: size, xOffset: 0, yOffset: 0, color: Colors.red),
                  new Opacity(
                    opacity: 0.9,
                    child: new WaveBody(
                      size: size,
                      xOffset: 60,
                      yOffset: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 13.0, right: 13.0, top: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Coin",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 14.0),
                    ),
                    Text(
                      "Total",
                      // "Value (USDT)",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WaveBody extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;

  WaveBody(
      {Key key, @required this.size, this.xOffset, this.yOffset, this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _WaveBodyState();
  }
}

class _WaveBodyState extends State<WaveBody> with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2 - widget.xOffset;
          i <= widget.size.width.toInt() + 2;
          i++) {
        animList1.add(new Offset(
            i.toDouble() + widget.xOffset,
            sin((animationController.value * 360 - i) %
                        360 *
                        Vector.degrees2Radians) *
                    20 +
                50 +
                widget.yOffset));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 185.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.repeated,
                  colors: [Color(0xFF6F2158), Color(0xFF6F2158)])),
          child: new Container(
            margin: EdgeInsets.only(top: 75.0),
            height: 20.0,
            child: new AnimatedBuilder(
              animation: new CurvedAnimation(
                parent: animationController,
                curve: Curves.easeInOut,
              ),
              builder: (context, child) => new ClipPath(
                child: widget.color == null
                    ? new Container(
                        width: widget.size.width,
                        height: widget.size.height,
                        color: Colors.white.withOpacity(0.25),
                      )
                    : new Container(
                        width: widget.size.width,
                        height: widget.size.height,
                        color: Colors.white.withOpacity(0.9),
                      ),
                clipper: new WaveClipper(animationController.value, animList1),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 180.0),
          height: 5.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                  Theme.of(context).scaffoldBackgroundColor
                ],
                stops: [
                  0.0,
                  1.0
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 1.0)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 70.0),
          alignment: Alignment.topCenter,
          child: Column(children: <Widget>[
            Text(
              "Estimated Balance (USDT)",
              style: TextStyle(fontFamily: "Popins", color: Colors.white),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "0.0",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "Popins",
                  fontSize: 30.0,
                  color: Colors.white),
            ),
          ]),
        )
      ],
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(5.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}

// takes in an object and color and returns a circle avatar with first letter and required color
CircleAvatar _getLeadingWidget(String name, Color color) {
  return new CircleAvatar(
    backgroundColor: color,
    child: new Text(name[0]),
  );
}

Widget walletList(
    assetsWallet item, WalletClass.Wallet wallet, BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(top: 7.0),
    child: Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Get.to(WalletDetail(wallet));
            // Navigator.of(ctx).push(PageRouteBuilder(
            //     pageBuilder: (_, __, ___) => new walletDetail()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 12.0),
                        // child: Image.asset(
                        //   item.icon,
                        //   height: 25.0,
                        //   fit: BoxFit.contain,
                        //   width: 22.0,
                        // ),
                        child: wallet.iconUrl != null
                            ? Image.network(
                                wallet.iconUrl,
                                height: 25.0,
                                fit: BoxFit.contain,
                                width: 22.0,
                              )
                            : IconButton(
                                onPressed: () {},
                                icon: new Icon(CryptoFontIconData(0xf000)),
                              )),
                    Container(
                      width: 95.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            wallet.currency.toUpperCase(),
                            style:
                                TextStyle(fontFamily: "Popins", fontSize: 16.5),
                          ),
                          Text(
                            wallet.balance,
                            style: TextStyle(
                                fontFamily: "Popins",
                                fontSize: 11.5,
                                color: Theme.of(ctx).hintColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        // (double.parse(wallet.balance) +
                        //         double.parse(wallet.locked))
                        //     .toStringAsFixed(wallet.precision),
                        (double.parse(wallet.balance) +
                                double.parse(wallet.locked))
                            .toString(),
                        style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 19.0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 20.0, top: 6.0),
          child: Container(
            width: double.infinity,
            height: 0.5,
            decoration:
                BoxDecoration(color: Theme.of(ctx).hintColor.withOpacity(0.1)),
          ),
        )
      ],
    ),
  );
}
