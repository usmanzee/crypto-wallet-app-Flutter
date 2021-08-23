import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuySellInitialAppealPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        centerTitle: true,
        title: Text(
          'Appeal an order',
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: Get.theme.hintColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Placeholder(
                              fallbackHeight: 100,
                              fallbackWidth: 50,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                'If there is an issue with the transaction, the most effective solution is to contact the counterparty directly. You can upload the payment receipt and account information in the chat window for both parties to verify and negotiate.',
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Get
                                      .theme.textSelectionTheme.selectionColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Get.theme.accentColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Chat',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    color: Get.theme.scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Appeal',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Get.theme.textSelectionTheme.selectionColor,
                        ),
                      ),
                    ),
                    _textWidget(
                      number: '1',
                      txt:
                          'Kindly note that once the transaction is completed, the assets are no longer held in Binance\'s custody,. The platform is unable to freeze the assets and cannot guarantee that your assets will be fully recovered after tge appeal is initiated.',
                    ),
                    _textWidget(
                      number: '2',
                      txt:
                          'The appeal will be processed with 12-48 hours, your patience is highly appreciated.',
                    ),
                    _textWidget(
                      number: '3',
                      txt:
                          'Malicious appeals disrupts teh normal operation of the platform. If the situation is severe, Binance will freeze the account.',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                top: 8,
              ),
              child: GestureDetector(
                onTap: () => Get.toNamed('/p2p_buy_sell_appeal_page'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'I want to appeal',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        color: Get.theme.accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textWidget({
    @required String number,
    @required String txt,
  }) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$number. ',
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              color: Get.theme.textSelectionTheme.selectionColor,
            ),
          ),
          TextSpan(
            text: txt,
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Get.theme.textSelectionTheme.selectionColor,
            ),
          ),
        ],
      ),
    );
  }
}
