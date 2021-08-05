import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/p2p/components/p2p_buy_sell_selected_offer_page_tab_layout/p2p_buy_sell_selected_offer_page_tab_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuySellSelectedOfferPage extends StatelessWidget {
  final currencySymbol = '\$';
  final _p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: Get.theme.hintColor,
          ),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        centerTitle: true,
        //todo: add the name here from the p2pOffer
        title: Text(
          'Buy USDT',
          style: TextStyle(
            fontFamily: "Popins",
            color: Get.theme.hintColor,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.hintColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  //todo: replace it with the real value
                  Text(
                    '3.68',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.hintColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  //todo add the currency symbol here
                  Text(
                    currencySymbol,
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Colors.greenAccent,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  //todo : add the value here of the refresh
                  Text(
                    '24s',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.hintColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.refresh,
                      size: 15,
                      color: Get.theme.hintColor,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'Limit ',
                      style: TextStyle(
                        fontFamily: "Popins",
                        color: Get.theme.hintColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    //todo: add the upper and lower limit from the data here
                    Obx(
                      () => Text(
                        _p2pController.fiatOrCrypto.value
                            ? '730.00$currencySymbol - 100.00$currencySymbol'
                            : 'Crypto value here',
                        style: TextStyle(
                          fontFamily: "Popins",
                          color: Get.theme.textSelectionTheme.selectionColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 10,
                child: Container(
                  height: Get.height * 0.4,
                  child: P2pBuySellSelectedOfferPageTabLayout(),
                ),
              ),
              //todo: add the callbacks here in necessary
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Container(
                  // width: Get.size.width,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Get.theme.accentColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Get.theme.accentColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '!',
                          style: TextStyle(
                            color: Get.theme.scaffoldBackgroundColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          'For the safety of your asset, a 24 hr withdrawal restriction will be imposed on the crypto purchased.',
                          maxLines: 4,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Get.theme.accentColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          softWrap: true,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 15,
                        color: Get.theme.hintColor,
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Trade Info',
                style: TextStyle(
                  fontFamily: "Popins",
                  color: Get.theme.textSelectionTheme.selectionColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Window',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed,
                      fontFamily: "Popins",
                      color: Get.theme.hintColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //todo: add value from the wallet here
                  Text(
                    '15 Minutes',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.textSelectionTheme.selectionColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Buyer\'s Nickname',
                      style: TextStyle(
                        fontFamily: "Popins",
                        color: Get.theme.hintColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Boost',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: "Popins",
                            color: Get.theme.textSelectionTheme.selectionColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Get.theme.hintColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seller Payment Method',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.hintColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //todo: add the checks for the bank names and color randomization
                      _bankNameWidget(bankName: 'Bank Transfer'),
                      _bankNameWidget(bankName: 'Bank Transfer'),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Container(
                  height: 0.3,
                  width: double.infinity,
                  color: Get.theme.hintColor,
                ),
              ),
              Text(
                'Terms',
                style: TextStyle(
                  color: Get.theme.textSelectionTheme.selectionColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              //todo: add the user p[hone number here if any is present
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'The advertise is only for cash deal for bulk quantity in Deira +92312345678 quantity whatsapp',
                  style: TextStyle(
                    fontFamily: "Popins",
                    color: Get.theme.hintColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bankNameWidget({@required String bankName}) {
    return Row(
      children: [
        Text(
          bankName,
          style: TextStyle(
            fontFamily: "Popins",
            color: Get.theme.textSelectionTheme.selectionColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          width: 4,
          color: Colors.pink,
          child: const Text(''),
        ),
      ],
    );
  }
}
