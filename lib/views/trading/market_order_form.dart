import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/trading_controller.dart';
import 'package:b4u_wallet/models/formated_market.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketOrderForm extends StatelessWidget {
  final FormatedMarket formatedMarket;
  MarketOrderForm({this.formatedMarket});
  final HomeController homeController = Get.find();
  final TradingController tradingController = Get.find<TradingController>();
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 50,
        child: Form(
          key: tradingController.marketBuyFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  color: Theme.of(context).canvasColor,
                  child: Center(
                    child: Text(
                        formatedMarket.last != null
                            ? "≃ " +
                                formatedMarket.last.toStringAsPrecision(
                                    formatedMarket.amountPrecision)
                            : '--',
                        style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Popins",
                            letterSpacing: 1.3,
                            fontSize: 16.0)),
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
                          controller: tradingController
                              .marketOrderBuyAmountTextController,
                          onChanged:
                              tradingController.onMarketOrderBuyAmountChange,
                          cursorColor: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => tradingController
                              .marketBuyTotalFocusNode
                              .requestFocus(),
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 12, bottom: 8, top: 8, right: 16),
                              hintText: formatedMarket.quoteUnit != null
                                  ? formatedMarket.quoteUnit.toUpperCase()
                                  : '',
                              hintStyle: TextStyle(fontSize: 14)),
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
                      children: tradingController.marketBuyFormPercentageOptions
                          .map((option) {
                        return InkWell(
                          onTap: () {
                            tradingController.percentageOptionClick(
                                'market', 'buy', option);
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
                          focusNode: tradingController.marketBuyTotalFocusNode,
                          controller: tradingController
                              .marketOrderBuyTotalTextController,
                          onChanged:
                              tradingController.onMarketOrderBuyTotalChange,
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
                                  ? "trading.screen.tab.market.buy.field.total"
                                      .trParams({
                                      'currency':
                                          formatedMarket.quoteUnit.toUpperCase()
                                    })
                                  : '',
                              hintStyle: TextStyle(fontSize: 14)),
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
                          'trading.screen.tab.market.buy.available'.tr,
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
                          'trading.screen.tab.market.buy.fee'.tr,
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
                                    .marketOrderBuyAmountTextController.text !=
                                '' &&
                            tradingController
                                    .marketOrderBuyTotalTextController.text !=
                                '') {
                          tradingController.marketOrderBuy();
                        }
                      },
                      child: Center(
                          child: Text(
                        formatedMarket.baseUnit != null
                            ? "trading.screen.tab.market.buy.button".trParams({
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
        key: tradingController.marketSellFormKey,
        child: Expanded(
          flex: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  color: Theme.of(context).canvasColor,
                  child: Center(
                    child: Text(
                        formatedMarket.last != null
                            ? "≃ " +
                                formatedMarket.last.toStringAsPrecision(
                                    formatedMarket.amountPrecision)
                            : '--',
                        style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Popins",
                            letterSpacing: 1.3,
                            fontSize: 16.0)),
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
                          controller: tradingController
                              .marketOrderSellAmountTextController,
                          onChanged:
                              tradingController.onMarketOrderSellAmountChange,
                          cursorColor: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => tradingController
                              .marketSellTotalFocusNode
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
                              hintText: formatedMarket.baseUnit != null
                                  ? formatedMarket.baseUnit.toUpperCase()
                                  : '',
                              hintStyle: TextStyle(fontSize: 14)),
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
                    children: tradingController.marketSellFormPercentageOptions
                        .map((option) {
                      return InkWell(
                        onTap: () {
                          tradingController.percentageOptionClick(
                              'market', 'sell', option);
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
                }),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Container(
                  color: Theme.of(context).canvasColor,
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          focusNode: tradingController.marketSellTotalFocusNode,
                          controller: tradingController
                              .marketOrderSellTotalTextController,
                          onChanged:
                              tradingController.onMarketOrderSellTotalChange,
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
                                  ? "trading.screen.tab.market.sell.field.total"
                                      .trParams({
                                      'currency':
                                          formatedMarket.quoteUnit.toUpperCase()
                                    })
                                  : '',
                              hintStyle: TextStyle(fontSize: 14)),
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
                          'trading.screen.tab.market.sell.available'.tr,
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
                          'trading.screen.tab.market.sell.fee'.tr,
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
                      color: Colors.redAccent.withOpacity(0.8),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (tradingController
                                    .marketOrderSellAmountTextController.text !=
                                '' &&
                            tradingController
                                    .marketOrderSellTotalTextController.text !=
                                '') {
                          tradingController.marketOrderSell();
                        }
                      },
                      child: Center(
                          child: Text(
                        formatedMarket.baseUnit != null
                            ? "trading.screen.tab.market.sell.button".trParams({
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

    if (formType == 'buy' && inputType == 'amount') {
      var existingNumber =
          tradingController.marketOrderBuyAmountTextController.text != ''
              ? double.parse(
                  tradingController.marketOrderBuyAmountTextController.text)
              : 0.0;

      tradingController.marketOrderBuyAmountTextController.text =
          (existingNumber + double.parse(finalNumber))
              .toStringAsFixed(percision);
      tradingController.onMarketOrderBuyAmountChange(
          tradingController.marketOrderBuyAmountTextController.text);
    }

    if (formType == 'sell' && inputType == 'amount') {
      var existingNumber =
          tradingController.marketOrderSellAmountTextController.text != ''
              ? double.parse(
                  tradingController.marketOrderSellAmountTextController.text)
              : 0.0;

      tradingController.marketOrderSellAmountTextController.text =
          (existingNumber + double.parse(finalNumber))
              .toStringAsFixed(percision);
      tradingController.onMarketOrderSellAmountChange(
          tradingController.marketOrderSellAmountTextController.text);
    }
  }

  void removeValueFromInput(
      BuildContext context, String formType, String inputType, int percision) {
    FocusScope.of(context).unfocus();
    var number = 1;
    var decimalPointNumber = number.toString().padRight(percision + 1, '0');
    var maxNumber = int.parse(decimalPointNumber);
    var finalNumber = (1 / maxNumber).toStringAsFixed(percision);

    if (formType == 'buy' && inputType == 'amount') {
      var existingNumber =
          tradingController.marketOrderBuyAmountTextController.text != ''
              ? double.parse(
                  tradingController.marketOrderBuyAmountTextController.text)
              : 0.0;

      if (existingNumber > 0) {
        var removedFinalAmount = (existingNumber - double.parse(finalNumber));
        tradingController.marketOrderBuyAmountTextController.text =
            removedFinalAmount == 0
                ? ''
                : removedFinalAmount.toStringAsFixed(percision);
        tradingController.onMarketOrderBuyAmountChange(
            tradingController.marketOrderBuyAmountTextController.text);
      }
    }

    if (formType == 'sell' && inputType == 'amount') {
      var existingNumber =
          tradingController.marketOrderSellAmountTextController.text != ''
              ? double.parse(
                  tradingController.marketOrderSellAmountTextController.text)
              : 0.0;

      if (existingNumber > 0) {
        var removedFinalAmount = (existingNumber - double.parse(finalNumber));
        tradingController.marketOrderSellAmountTextController.text =
            removedFinalAmount == 0
                ? ''
                : removedFinalAmount.toStringAsFixed(percision);

        tradingController.onMarketOrderSellAmountChange(
            tradingController.marketOrderSellAmountTextController.text);
      }
    }
  }
}
