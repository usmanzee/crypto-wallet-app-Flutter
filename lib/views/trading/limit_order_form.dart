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
                    GestureDetector(
                        onTap: () {
                          removeValueFromInput(
                              'buy', 'price', formatedMarket.pricePrecision);
                        },
                        child: Icon(Icons.remove)),
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
                    GestureDetector(
                        onTap: () {
                          addValueToInput(
                              'buy', 'price', formatedMarket.pricePrecision);
                        },
                        child: Icon(Icons.add)),
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
                    GestureDetector(
                        onTap: () {
                          removeValueFromInput(
                              'buy', 'amount', formatedMarket.pricePrecision);
                        },
                        child: Icon(Icons.remove)),
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
                    GestureDetector(
                        onTap: () {
                          addValueToInput(
                              'buy', 'amount', formatedMarket.amountPrecision);
                        },
                        child: Icon(Icons.add)),
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
                            hintText: formatedMarket.quoteUnit != null
                                ? "Total( " +
                                    formatedMarket.quoteUnit.toUpperCase() +
                                    ")"
                                : ''),
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
                        Text(
                            formatedMarket.quoteUnit != null
                                ? ' ' + formatedMarket.quoteUnit.toUpperCase()
                                : ' --',
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
                      if (tradingController
                                  .limitOrderBuyPriceTextController.text !=
                              '' &&
                          tradingController
                                  .limitOrderBuyAmountTextController.text !=
                              '' &&
                          tradingController
                                  .limitOrderBuyTotalTextController.text !=
                              '') {
                        tradingController.limitOrderBuy();
                      }
                    },
                    child: Center(
                        child: Text(
                      formatedMarket.baseUnit != null
                          ? "Buy " + formatedMarket.baseUnit.toUpperCase()
                          : '',
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
                    GestureDetector(
                        onTap: () {
                          removeValueFromInput(
                              'sell', 'price', formatedMarket.pricePrecision);
                        },
                        child: Icon(Icons.remove)),
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
                    GestureDetector(
                        onTap: () {
                          addValueToInput(
                              'sell', 'price', formatedMarket.pricePrecision);
                        },
                        child: Icon(Icons.add)),
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
                    GestureDetector(
                        onTap: () {
                          removeValueFromInput(
                              'sell', 'amount', formatedMarket.pricePrecision);
                        },
                        child: Icon(Icons.remove)),
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
                    GestureDetector(
                        onTap: () {
                          addValueToInput(
                              'sell', 'amount', formatedMarket.pricePrecision);
                        },
                        child: Icon(Icons.add)),
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
                            hintText: formatedMarket.baseUnit != null
                                ? "Total (" +
                                    formatedMarket.baseUnit.toUpperCase() +
                                    ")"
                                : ''),
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
                      Text(
                          formatedMarket.baseUnit != null
                              ? ' ' + formatedMarket.baseUnit.toUpperCase()
                              : ' --',
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
                    onPressed: () {
                      if (tradingController
                                  .limitOrderSellAmountTextController.text !=
                              '' &&
                          tradingController
                                  .limitOrderSellPriceTextController.text !=
                              '' &&
                          tradingController
                                  .limitOrderSellTotalTextController.text !=
                              '') {
                        tradingController.limitOrderSell();
                      }
                    },
                    child: Center(
                        child: Text(
                      formatedMarket.baseUnit != null
                          ? "Sell " + formatedMarket.baseUnit.toUpperCase()
                          : '',
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

  void addValueToInput(String formType, String inputType, int percision) {
    var number = 1;
    var decimalPointNumber = number.toString().padRight(percision + 1, '0');
    var maxNumber = int.parse(decimalPointNumber);
    var finalNumber = (1 / maxNumber).toStringAsFixed(percision);
    if (formType == 'buy' && inputType == 'price') {
      var existingNumber =
          tradingController.limitOrderBuyPriceTextController.text != ''
              ? double.parse(
                  tradingController.limitOrderBuyPriceTextController.text)
              : 0.0;

      tradingController.limitOrderBuyPriceTextController.text =
          (existingNumber + double.parse(finalNumber))
              .toStringAsFixed(percision);
      tradingController.onLimitOrderBuyPriceChange(
          tradingController.limitOrderBuyPriceTextController.text);
    }
    if (formType == 'buy' && inputType == 'amount') {
      var existingNumber =
          tradingController.limitOrderBuyAmountTextController.text != ''
              ? double.parse(
                  tradingController.limitOrderBuyAmountTextController.text)
              : 0.0;

      tradingController.limitOrderBuyAmountTextController.text =
          (existingNumber + double.parse(finalNumber))
              .toStringAsFixed(percision);
      tradingController.onLimitOrderBuyAmountChange(
          tradingController.limitOrderBuyAmountTextController.text);
    }
    if (formType == 'sell' && inputType == 'price') {
      var existingNumber =
          tradingController.limitOrderSellPriceTextController.text != ''
              ? double.parse(
                  tradingController.limitOrderSellPriceTextController.text)
              : 0.0;

      tradingController.limitOrderSellPriceTextController.text =
          (existingNumber + double.parse(finalNumber))
              .toStringAsFixed(percision);
      tradingController.onLimitOrderSellPriceChange(
          tradingController.limitOrderSellPriceTextController.text);
    }
    if (formType == 'sell' && inputType == 'amount') {
      var existingNumber =
          tradingController.limitOrderSellAmountTextController.text != ''
              ? double.parse(
                  tradingController.limitOrderSellAmountTextController.text)
              : 0.0;

      tradingController.limitOrderSellAmountTextController.text =
          (existingNumber + double.parse(finalNumber))
              .toStringAsFixed(percision);
      tradingController.onLimitOrderSellAmountChange(
          tradingController.limitOrderSellAmountTextController.text);
    }
  }

  void removeValueFromInput(String formType, String inputType, int percision) {
    var number = 1;
    var decimalPointNumber = number.toString().padRight(percision + 1, '0');
    var maxNumber = int.parse(decimalPointNumber);
    var finalNumber = (1 / maxNumber).toStringAsFixed(percision);
    if (formType == 'buy' && inputType == 'price') {
      var existingNumber =
          tradingController.limitOrderBuyPriceTextController.text != ''
              ? double.parse(
                  tradingController.limitOrderBuyPriceTextController.text)
              : 0.0;

      if (existingNumber > 0) {
        tradingController.limitOrderBuyPriceTextController.text =
            (existingNumber - double.parse(finalNumber))
                .toStringAsFixed(percision);
        tradingController.onLimitOrderBuyPriceChange(
            tradingController.limitOrderBuyPriceTextController.text);
      }
    }
    if (formType == 'buy' && inputType == 'amount') {
      var existingNumber =
          tradingController.limitOrderBuyAmountTextController.text != ''
              ? double.parse(
                  tradingController.limitOrderBuyAmountTextController.text)
              : 0.0;

      if (existingNumber > 0) {
        tradingController.limitOrderBuyAmountTextController.text =
            (existingNumber - double.parse(finalNumber))
                .toStringAsFixed(percision);
        tradingController.onLimitOrderBuyAmountChange(
            tradingController.limitOrderBuyAmountTextController.text);
      }
    }
    if (formType == 'sell' &&
        inputType == 'price' &&
        tradingController.limitOrderSellPriceTextController.text != '') {
      var existingNumber =
          tradingController.limitOrderSellPriceTextController.text != ''
              ? double.parse(
                  tradingController.limitOrderSellPriceTextController.text)
              : 0.0;

      if (existingNumber > 0) {
        tradingController.limitOrderSellPriceTextController.text =
            (existingNumber - double.parse(finalNumber))
                .toStringAsFixed(percision);
        tradingController.onLimitOrderSellPriceChange(
            tradingController.limitOrderSellPriceTextController.text);
      }
    }
    if (formType == 'sell' &&
        inputType == 'amount' &&
        tradingController.limitOrderSellAmountTextController.text != '') {
      var existingNumber =
          tradingController.limitOrderSellAmountTextController.text != ''
              ? double.parse(
                  tradingController.limitOrderSellAmountTextController.text)
              : 0.0;

      if (existingNumber > 0) {
        tradingController.limitOrderSellAmountTextController.text =
            (existingNumber - double.parse(finalNumber))
                .toStringAsFixed(percision);
        tradingController.onLimitOrderSellAmountChange(
            tradingController.limitOrderSellAmountTextController.text);
      }
    }
  }
}
