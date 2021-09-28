import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget containerTrade({
  String name,
  String price,
  String currency,
  String lowerLimit,
  String upperLimit,
  String functionText,
  String trades,
  String reviewPercentage,
  String bankName,
  String tabCurrencyName,
  String cryptoAmount,
  Function functionCallback,
  Function nameCallback,
  String currencySymbol,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: nameCallback,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Get.theme.accentColor,
                    ),
                    child: Text(
                      name[0],
                      style: TextStyle(
                        color: Get.theme.scaffoldBackgroundColor,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    name,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '$trades Trades',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.textSelectionTheme.selectionColor
                          .withOpacity(0.6),
                      // fontSize: 20.0,
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    '$reviewPercentage%',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.textSelectionTheme.selectionColor
                          .withOpacity(0.6),
                      // fontSize: 20.0,
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: functionCallback,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Price',
                  style: TextStyle(
                    fontFamily: "Popins",
                    color: Get.theme.textSelectionTheme.selectionColor
                        .withOpacity(0.6),
                    // fontSize: 20.0,
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                        fontFamily: "Popins",
                        color: Get.theme.textSelectionTheme.selectionColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        height: 2),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Text(
                    currency.toUpperCase(),
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.textSelectionTheme.selectionColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Crypto Amount',
                            style: TextStyle(
                              fontFamily: "Popins",
                              color: Get.theme.textSelectionTheme.selectionColor
                                  .withOpacity(0.6),
                              // fontSize: 20.0,
                              // fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Text(
                              '$cryptoAmount ${tabCurrencyName.toUpperCase()}'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Limit',
                            style: TextStyle(
                              color: Get.theme.textSelectionTheme.selectionColor
                                  .withOpacity(0.6),
                              // fontSize: 20.0,
                              // fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Text(
                              '$currencySymbol $lowerLimit - $currencySymbol $upperLimit'),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: functionCallback,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color:
                            functionText == 'sell' ? Colors.red : Colors.green,
                        borderRadius: BorderRadius.circular(
                          4,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          functionText,
                          style: TextStyle(
                            color: Get.theme.scaffoldBackgroundColor,
                            // fontSize: 20.0,
                            // fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: bankNameWidget(bankName: bankName),
              ),
              Container(
                width: double.infinity,
                height: 0.3,
                color: Get.theme.textSelectionTheme.selectionColor
                    .withOpacity(0.6),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget bankNameWidget({
  String bankName,
}) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(1),
        ),
        height: 10,
        width: 3,
      ),
      SizedBox(
        width: 4.0,
      ),
      Text(
        bankName,
        style: TextStyle(
          fontFamily: "Popins",
          color: Get.theme.textSelectionTheme.selectionColor.withOpacity(0.6),
          fontSize: 9.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}
