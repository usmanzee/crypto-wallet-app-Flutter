import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ByFiat extends StatelessWidget {
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
                    //todo: add the icon here after finalizing the json for the icons
                    Text(
                      '\@',
                      style: TextStyle(),
                    ),
                    SizedBox(
                      width: 16,
                    ),
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
                          hintText: 'Enter amount',
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
          Container(
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
