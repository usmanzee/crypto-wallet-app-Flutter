import 'dart:math';

import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferWidget extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();
  final String type;
  final String asset;
  final String fiat;
  final String status;
  final String fiatCurrency;
  final String priceInFiat;
  final String totalAmount;
  final String lowerLimit;
  final String upperLimit;
  final String bankName;
  final int index;

  OfferWidget({
    @required this.type,
    @required this.asset,
    @required this.fiat,
    @required this.status,
    @required this.fiatCurrency,
    @required this.priceInFiat,
    @required this.totalAmount,
    @required this.lowerLimit,
    @required this.upperLimit,
    @required this.bankName,
    @required this.index,
  });

  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Get.theme.canvasColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    type,
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: type == 'sell'
                          ? Colors.redAccent
                          : Colors.greenAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      asset,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Get.theme.textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                  Text(
                    'With',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Get.theme.hintColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      fiat,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Get.theme.textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 8),
                      decoration: BoxDecoration(
                          color:
                              _p2pController.userAddedP2pOffers[index].state ==
                                      'active'
                                  ? Colors.greenAccent.withOpacity(0.3)
                                  : Colors.redAccent.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2)),
                      child: Text(
                        _p2pController.userAddedP2pOffers[index].state ==
                                'active'
                            ? 'Online'
                            : 'Offline',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color:
                              _p2pController.userAddedP2pOffers[index].state ==
                                      'active'
                                  ? Colors.green
                                  : Colors.redAccent,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    CupertinoSwitch(
                      activeColor: Get.theme.accentColor,
                      value: _p2pController.userAddedP2pOffers[index].state ==
                              'active'
                          ? true
                          : false,
                      trackColor: Get.theme.hintColor,
                      onChanged: (value) {
                        //todo: add the api callback here for making it online and offline and also make that specific indexed value changed and refresh the list
                        if (value) {
                          _p2pController.userAddedP2pOffers[index].state =
                              'inactive';
                          _p2pController.userAddedP2pOffers.refresh();
                          print('yes');
                        } else {
                          _p2pController.userAddedP2pOffers[index].state =
                              'active';
                          _p2pController.userAddedP2pOffers.refresh();
                          print('yes2');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                fiatCurrency,
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                priceInFiat,
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 24.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total amount',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.hintColor,
                ),
              ),
              Text(
                '$totalAmount $asset',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Limit',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.hintColor,
                ),
              ),
              Text(
                '$lowerLimit - $upperLimit $fiat',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.primaries[
                            _random.nextInt(Colors.primaries.length)],
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: Text(' '),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    //todo: add a listView here when you have the values
                    Text(
                      bankName,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Get.theme.hintColor,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  //todo: add the onTap here for the widget callback
                  child: Icon(
                    Icons.more_vert,
                    color: Get.theme.textSelectionTheme.selectionColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
