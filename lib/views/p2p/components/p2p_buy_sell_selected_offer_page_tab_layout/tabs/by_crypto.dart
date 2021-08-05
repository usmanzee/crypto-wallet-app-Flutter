import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ByCrypto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 16,
                ),
                color: Get.theme.canvasColor,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        maxLength: 13,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: 'Enter quantity',
                        ),
                      ),
                    ),
                    // todo: add the currency name here from the data
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        'USDT',
                        style: TextStyle(
                          color: Get.theme.hintColor,
                          fontSize: 14,
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    GestureDetector(
                      //todo: add the value here for the max available in the account.
                      onTap: () {},
                      child: Text(
                        'All',
                        style: TextStyle(
                          color: Get.theme.accentColor,
                          fontSize: 16,
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                  bottom: 8,
                ),
                child: _row(first: 'first', second: 'second'),
              ),
              _row(first: 'first', second: 'second'),
            ],
          ),
          GestureDetector(
            onTap: () => Get.toNamed('/p2p_buy_payment_pending_page'),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Get.theme.accentColor,
                borderRadius: BorderRadius.circular(
                  4,
                ),
              ),
              child: Center(
                //todo: replace with the currency name buying
                child: Text(
                  'Buy USDT',
                  style: TextStyle(
                    color: Get.theme.scaffoldBackgroundColor,
                    fontSize: 16,
                    fontFamily: 'Popins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row({@required String first, @required String second}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          first,
          style: TextStyle(
            color: Get.theme.hintColor,
            fontSize: 14,
            fontFamily: 'Popins',
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '--$second',
          style: TextStyle(
            color: Get.theme.accentColor,
            fontSize: 14,
            fontFamily: 'Popins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
