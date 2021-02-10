import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/trading_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LimitOrderForm extends StatelessWidget {
  final FormatedMarket formatedMarket;
  LimitOrderForm({this.formatedMarket});
  final HomeController homeController = Get.find();
  final TradingController tradingController = Get.find<TradingController>();
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
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {},
                    ),
                    Flexible(
                      child: TextFormField(
                        controller:
                            tradingController.limitOrderBuyPriceTextController,
                        onChanged: tradingController.onLimitOrderBuyPriceChange,
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
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {},
                    ),
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
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {},
                    ),
                    Flexible(
                      child: TextFormField(
                        controller:
                            tradingController.limitOrderBuyAmountTextController,
                        onChanged:
                            tradingController.onLimitOrderBuyAmountChange,
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
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {},
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
                        onChanged: tradingController.onLimitOrderBuyTotalChange,
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
                            hintText: "Total( " +
                                formatedMarket.quoteUnit.toUpperCase() +
                                ")"),
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
                      child: Row(children: [
                        Text(
                            tradingController.walletQuote.value.balance != null
                                ? tradingController.walletQuote.value.balance
                                : '--',
                            style: TextStyle(
                              color: Theme.of(context).textSelectionColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Popins",
                              letterSpacing: 1.3,
                            )),
                        Text(' ' + formatedMarket.quoteUnit.toUpperCase(),
                            style: TextStyle(
                              color: Theme.of(context).textSelectionColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Popins",
                              letterSpacing: 1.3,
                            ))
                      ]),
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
                    onPressed: () {
                      tradingController.limitOrderBuy();
                    },
                    child: Center(
                        child: Text(
                      "Buy " + formatedMarket.baseUnit.toUpperCase(),
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
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {},
                    ),
                    Flexible(
                      child: TextFormField(
                        controller:
                            tradingController.limitOrderSellPriceTextController,
                        onChanged:
                            tradingController.onLimitOrderSellPriceChange,
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
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {},
                    ),
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
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {},
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: tradingController
                            .limitOrderSellAmountTextController,
                        onChanged:
                            tradingController.onLimitOrderSellAmountChange,
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
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {},
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
                        onChanged:
                            tradingController.onLimitOrderSellTotalChange,
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
                            hintText: "Total (" +
                                formatedMarket.baseUnit.toUpperCase() +
                                ")"),
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
                        child: Row(children: [
                      Text(
                          tradingController.walletBase.value.balance != null
                              ? tradingController.walletBase.value.balance
                              : '--',
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Popins",
                            letterSpacing: 1.3,
                          )),
                      Text(' ' + formatedMarket.baseUnit.toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Popins",
                            letterSpacing: 1.3,
                          ))
                    ])),
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
                      "Sell " + formatedMarket.baseUnit.toUpperCase(),
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
