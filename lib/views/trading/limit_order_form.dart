import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/trading_controller.dart';
import 'package:b4u_wallet/models/formated_market.dart';
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
        child: Form(
          key: tradingController.limitBuyFormKey,
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
                            removeValueFromInput(context, 'buy', 'price', 2);
                          },
                          child: Icon(Icons.remove)),
                      Flexible(
                        child: TextFormField(
                          controller: tradingController
                              .limitOrderBuyPriceTextController,
                          onChanged:
                              tradingController.onLimitOrderBuyPriceChange,
                          cursorColor: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => tradingController
                              .limitBuyAmountFocusNode
                              .requestFocus(),
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText:
                                  "trading.screen.tab.limit.buy.field.price"
                                      .tr),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            addValueToInput(context, 'buy', 'price', 2);
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
                            removeValueFromInput(context, 'buy', 'amount', 6);
                          },
                          child: Icon(Icons.remove)),
                      Flexible(
                        child: TextFormField(
                          focusNode: tradingController.limitBuyAmountFocusNode,
                          controller: tradingController
                              .limitOrderBuyAmountTextController,
                          onChanged:
                              tradingController.onLimitOrderBuyAmountChange,
                          cursorColor: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => tradingController
                              .limitBuyTotalFocusNode
                              .requestFocus(),
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText:
                                  "trading.screen.tab.limit.buy.field.amount"
                                      .tr),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            addValueToInput(context, 'buy', 'amount', 6);
                          },
                          child: Icon(Icons.add)),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: tradingController.limitBuyFormPercentageOptions
                          .map((option) {
                        return InkWell(
                          onTap: () {
                            tradingController.percentageOptionClick(
                                'limit', 'buy', option);
                          },
                          child: Container(
                            width: 40,
                            decoration: BoxDecoration(
                                color: option.isActive
                                    ? Color(0xFF2ebd85)
                                    : Theme.of(context).canvasColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            padding: EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                option.name,
                                style: TextStyle(
                                    color: option.isActive
                                        ? Colors.white
                                        : Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  })),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Container(
                  color: Theme.of(context).canvasColor,
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          focusNode: tradingController.limitBuyTotalFocusNode,
                          controller: tradingController
                              .limitOrderBuyTotalTextController,
                          onChanged:
                              tradingController.onLimitOrderBuyTotalChange,
                          cursorColor: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
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
                                  ? "trading.screen.tab.limit.buy.field.total"
                                      .trParams({
                                      'currency':
                                          formatedMarket.quoteUnit.toUpperCase()
                                    })
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
                      padding: EdgeInsets.only(left: 4.0),
                      child: Center(
                        child: Text(
                          'trading.screen.tab.limit.buy.available'.tr,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Center(
                        child: Row(children: [
                          Text(
                              tradingController.walletQuote.value.balance !=
                                      null
                                  ? tradingController.walletQuote.value.balance
                                  : '--',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
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
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
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
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Center(
                        child: Text(
                          'trading.screen.tab.limit.buy.fee'.tr,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Center(
                          child: Row(children: [
                        Text(
                            tradingController.marketTradingFee.taker != null
                                ? (double.parse(tradingController
                                                .marketTradingFee.taker) *
                                            100)
                                        .toString() +
                                    '%'
                                : '--%',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Popins",
                              letterSpacing: 1.3,
                            )),
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
                      color: Color(0xFF2ebd85),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
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
                            ? "trading.screen.tab.limit.buy.button".trParams({
                                'currency':
                                    formatedMarket.baseUnit.toUpperCase()
                              })
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
      ),
      SizedBox(
        width: 8.0,
      ),
      Form(
        key: tradingController.limitSellFormKey,
        child: Expanded(
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
                            removeValueFromInput(context, 'sell', 'price', 2);
                          },
                          child: Icon(Icons.remove)),
                      Flexible(
                        child: TextFormField(
                          controller: tradingController
                              .limitOrderSellPriceTextController,
                          onChanged:
                              tradingController.onLimitOrderSellPriceChange,
                          cursorColor: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => tradingController
                              .limitSellAmountFocusNode
                              .requestFocus(),
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText:
                                  "trading.screen.tab.limit.sell.field.price"
                                      .tr),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            addValueToInput(context, 'sell', 'price', 2);
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
                            removeValueFromInput(context, 'sell', 'amount', 6);
                          },
                          child: Icon(Icons.remove)),
                      Flexible(
                        child: TextFormField(
                          focusNode: tradingController.limitSellAmountFocusNode,
                          controller: tradingController
                              .limitOrderSellAmountTextController,
                          onChanged:
                              tradingController.onLimitOrderSellAmountChange,
                          cursorColor: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => tradingController
                              .limitSellTotalFocusNode
                              .requestFocus(),
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText:
                                  "trading.screen.tab.limit.sell.field.amount"
                                      .tr),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            addValueToInput(context, 'sell', 'amount', 6);
                          },
                          child: Icon(Icons.add)),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: tradingController.limitSellFormPercentageOptions
                          .map((option) {
                        return InkWell(
                          onTap: () {
                            tradingController.percentageOptionClick(
                                'limit', 'sell', option);
                          },
                          child: Container(
                            width: 40,
                            decoration: BoxDecoration(
                                color: option.isActive
                                    ? Colors.redAccent.withOpacity(0.8)
                                    : Theme.of(context).canvasColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            padding: EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                option.name,
                                style: TextStyle(
                                    color: option.isActive
                                        ? Colors.white
                                        : Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  })),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Container(
                  color: Theme.of(context).canvasColor,
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          focusNode: tradingController.limitSellTotalFocusNode,
                          controller: tradingController
                              .limitOrderSellTotalTextController,
                          onChanged:
                              tradingController.onLimitOrderSellTotalChange,
                          cursorColor: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
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
                                  ? "trading.screen.tab.limit.sell.field.total"
                                      .trParams({
                                      'currency':
                                          formatedMarket.quoteUnit.toUpperCase()
                                    })
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
                      padding: EdgeInsets.only(left: 4.0),
                      child: Center(
                        child: Text(
                          'trading.screen.tab.limit.sell.available'.tr,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Center(
                          child: Row(children: [
                        Text(
                            tradingController.walletBase.value.balance != null
                                ? tradingController.walletBase.value.balance
                                : '--',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
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
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
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
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Center(
                        child: Text(
                          'trading.screen.tab.limit.sell.fee'.tr,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Center(
                          child: Row(children: [
                        Text(
                            tradingController.marketTradingFee.maker != null
                                ? (double.parse(tradingController
                                                .marketTradingFee.maker) *
                                            100)
                                        .toString() +
                                    '%'
                                : '--%',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Popins",
                              letterSpacing: 1.3,
                            )),
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
                        FocusScope.of(context).unfocus();
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
                            ? "trading.screen.tab.limit.sell.button".trParams({
                                'currency':
                                    formatedMarket.baseUnit.toUpperCase()
                              })
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
      )
    ]);
  }

  void addValueToInput(
      BuildContext context, String formType, String inputType, int percision) {
    FocusScope.of(context).unfocus();
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

  void removeValueFromInput(
      BuildContext context, String formType, String inputType, int percision) {
    FocusScope.of(context).unfocus();
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
        var removedFinalAmount = (existingNumber - double.parse(finalNumber));

        tradingController.limitOrderBuyPriceTextController.text =
            removedFinalAmount == 0
                ? ''
                : removedFinalAmount.toStringAsFixed(percision);
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
        var removedFinalAmount = (existingNumber - double.parse(finalNumber));
        tradingController.limitOrderBuyAmountTextController.text =
            removedFinalAmount == 0
                ? ''
                : removedFinalAmount.toStringAsFixed(percision);
        tradingController.onLimitOrderBuyAmountChange(
            tradingController.limitOrderBuyAmountTextController.text);

        // tradingController.limitOrderBuyAmountTextController.text =
        //     (existingNumber - double.parse(finalNumber))
        //         .toStringAsFixed(percision);
        // tradingController.onLimitOrderBuyAmountChange(
        //     tradingController.limitOrderBuyAmountTextController.text);
      }
    }
    if (formType == 'sell' && inputType == 'price') {
      var existingNumber =
          tradingController.limitOrderSellPriceTextController.text != ''
              ? double.parse(
                  tradingController.limitOrderSellPriceTextController.text)
              : 0.0;

      if (existingNumber > 0) {
        var removedFinalAmount = (existingNumber - double.parse(finalNumber));
        tradingController.limitOrderSellPriceTextController.text =
            removedFinalAmount == 0
                ? ''
                : removedFinalAmount.toStringAsFixed(percision);
        tradingController.onLimitOrderSellPriceChange(
            tradingController.limitOrderSellPriceTextController.text);
      }
    }
    if (formType == 'sell' && inputType == 'amount') {
      var existingNumber =
          tradingController.limitOrderSellAmountTextController.text != ''
              ? double.parse(
                  tradingController.limitOrderSellAmountTextController.text)
              : 0.0;

      if (existingNumber > 0) {
        var removedFinalAmount = (existingNumber - double.parse(finalNumber));
        tradingController.limitOrderSellAmountTextController.text =
            removedFinalAmount == 0
                ? ''
                : removedFinalAmount.toStringAsFixed(percision);
        tradingController.onLimitOrderSellAmountChange(
            tradingController.limitOrderSellAmountTextController.text);
      }
    }
  }
}
