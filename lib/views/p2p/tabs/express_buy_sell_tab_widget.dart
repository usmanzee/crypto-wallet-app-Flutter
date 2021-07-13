import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final p2pController = Get.find<P2pController>();

Widget expressBuySellTabWidget(
    {String currencyName,
    bool transfer,
    String buyingCurrency,
    String hintFirstText,
    String hintSecondText,
    String referencePrice}) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 16,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        top: 8,
                      ),
                      //todo: change the text with the selected function,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total amount',
                            style: TextStyle(
                              fontFamily: "Popins",
                              color: Get.theme.textSelectionTheme.selectionColor
                                  .withOpacity(0.5),
                              fontSize: 14.0,
                              // height: 1,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          transfer
                              ? Container()
                              : GestureDetector(
                                  onTap: () {
                                    Get.put(WalletController());
                                    Get.toNamed('/transfer_page');
                                  },
                                  child: Text(
                                    'Transfer',
                                    style: TextStyle(
                                        fontFamily: "Popins",
                                        color: Get.theme.accentColor,
                                        fontSize: 14.0,
                                        // height: 1,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Get.theme.textSelectionTheme.selectionColor
                            .withOpacity(0.09),
                      ),
                      child: Row(
                        children: [
                          p2pController.cryptoOrCash.value
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    left: 6,
                                  ),
                                  child: Text(
                                    buyingCurrency,
                                    style: TextStyle(
                                      fontFamily: "Popins",
                                      color: Get.theme.textSelectionTheme
                                          .selectionColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Container(),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  //todo: change it with the option changed,
                                  hintText: '$hintFirstText $hintSecondText',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          p2pController.cryptoOrCash.value
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        currencyName.toUpperCase(),
                                        style: TextStyle(
                                          fontFamily: "Popins",
                                          color: Get.theme.textSelectionTheme
                                              .selectionColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'MAX',
                                        style: TextStyle(
                                          fontFamily: "Popins",
                                          color: Get.theme.accentColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Refrence price',
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  color: Get
                                      .theme.textSelectionTheme.selectionColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              // todo: add teh currency symbol here and the reference value from the server,
                              Row(
                                children: [
                                  Text(
                                    buyingCurrency,
                                    style: TextStyle(
                                      fontFamily: "Popins",
                                      color: Get.theme.hintColor,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    referencePrice,
                                    style: TextStyle(
                                      fontFamily: "Popins",
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              p2pController.cryptoOrCash.value =
                                  !p2pController.cryptoOrCash.value;
                            },
                            child: Row(
                              children: [
                                Text(
                                  //todo: add the values here after translation
                                  p2pController.cryptoOrCash.value
                                      ? 'By crypto'
                                      : 'By cash',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    color: Get.theme.accentColor,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  Icons.swap_horiz,
                                  size: 16,
                                  color: Get.theme.accentColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          print(p2pController.buyOrSellExpress.value);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: p2pController.buyOrSellExpress.value
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            //todo: change text with the variables,
                            child: Text(
                              'Buy with 0 Fee',
                              style: TextStyle(
                                fontFamily: "Popins",
                                color: Get.theme.scaffoldBackgroundColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
