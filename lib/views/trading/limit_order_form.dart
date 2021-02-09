import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/trading_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LimitOrderForm extends StatefulWidget {
  @override
  _LimitOrderFormState createState() => _LimitOrderFormState();
}

class _LimitOrderFormState extends State<LimitOrderForm> {
  HomeController homeController = Get.find();
  final TradingController tradingController = Get.find(tag: 'trading_instance');
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Row(
                  children: [
                    Icon(Icons.remove),
                    Flexible(
                      child: TextFormField(
                        controller:
                            tradingController.limitOrderBuyPriceTextController,
                        cursorColor: Theme.of(context).textSelectionColor,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Price"),
                      ),
                    ),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Row(
                  children: [
                    Icon(Icons.remove),
                    Flexible(
                      child: TextFormField(
                        controller:
                            tradingController.limitOrderBuyAmountTextController,
                        cursorColor: Theme.of(context).textSelectionColor,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Amount"),
                      ),
                    ),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      print('25%');
                    },
                    child: Container(
                      width: 40,
                      color: Theme.of(context).canvasColor,
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          '25%',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('50%');
                    },
                    child: Container(
                      width: 40,
                      color: Theme.of(context).canvasColor,
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          '50%',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('75%');
                    },
                    child: Container(
                      width: 40,
                      color: Theme.of(context).canvasColor,
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          '75%',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('100%');
                    },
                    child: Container(
                      width: 40,
                      color: Theme.of(context).canvasColor,
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          '100%',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller:
                            tradingController.limitOrderBuyTotalTextController,
                        cursorColor: Theme.of(context).textSelectionColor,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        enabled: false,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Total(BTC)"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        'Avbl',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        '0.00 BTC',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (homeController.isLoggedIn.value)
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 40.0,
                  child: MaterialButton(
                    splashColor: Colors.black12,
                    highlightColor: Colors.black12,
                    color: Color(0xFF2ebd85),
                    onPressed: () {},
                    child: Center(
                        child: Text(
                      "Buy",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Popins",
                          letterSpacing: 1.3,
                          fontSize: 16.0),
                    )),
                  ),
                ),
              )
            else
              Container(
                height: 0,
                width: 0,
              )
          ],
        ),
      ),
      SizedBox(
        width: 8.0,
      ),
      Expanded(
        flex: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Row(
                  children: [
                    Icon(Icons.remove),
                    Flexible(
                      child: TextFormField(
                        controller:
                            tradingController.limitOrderSellPriceTextController,
                        cursorColor: Theme.of(context).textSelectionColor,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Price"),
                      ),
                    ),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Row(
                  children: [
                    Icon(Icons.remove),
                    Flexible(
                      child: TextFormField(
                        controller: tradingController
                            .limitOrderSellAmountTextController,
                        cursorColor: Theme.of(context).textSelectionColor,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Amount"),
                      ),
                    ),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      print('25%');
                    },
                    child: Container(
                      width: 40,
                      color: Theme.of(context).canvasColor,
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          '25%',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('50%');
                    },
                    child: Container(
                      width: 40,
                      color: Theme.of(context).canvasColor,
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          '50%',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('75%');
                    },
                    child: Container(
                      width: 40,
                      color: Theme.of(context).canvasColor,
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          '75%',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('100%');
                    },
                    child: Container(
                      width: 40,
                      color: Theme.of(context).canvasColor,
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          '100%',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller:
                            tradingController.limitOrderSellTotalTextController,
                        cursorColor: Theme.of(context).textSelectionColor,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        enabled: false,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Total(BTC)"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        'Avbl',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        '0.00 BTC',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (homeController.isLoggedIn.value)
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 40.0,
                  child: MaterialButton(
                    splashColor: Colors.black12,
                    highlightColor: Colors.black12,
                    color: Colors.redAccent.withOpacity(0.8),
                    onPressed: () {},
                    child: Center(
                        child: Text(
                      "Sell",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Popins",
                          letterSpacing: 1.3,
                          fontSize: 16.0),
                    )),
                  ),
                ),
              )
            else
              Container(
                height: 0,
                width: 0,
              )
          ],
        ),
      )
    ]);
  }
}
