import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:b4u_wallet/views/widgets/question_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvancedTab extends StatelessWidget {
  final PageController mPageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 52,
              left: 12,
              right: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Common Scams',
                  style: TextStyle(
                    fontFamily: "Popins",
                    color: Get.theme.textSelectionTheme.selectionColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  // color: Colors.pink[100],
                  height: 370,
                  child: PageView.builder(
                    controller: mPageController,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) {},
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return viewPagerWidget(
                        comment1:
                            'The buyer sends a fake Payment SMS notification to the seller, and the seller releases the cryptos without confirming the payment was received.',
                        comment2:
                            'When verifying the payment received, br aware of fake SMS from the buyer, Please log in to your payment account and verify the correct amount is received',
                        header: 'SMS fraud',
                        photoUrl: MyImgs.testPhoto,
                      );
                    },
                  ),
                ),
                moreText(text: 'More Scams'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  child: line(),
                ),
                Text(
                  'Frozen Fund Help',
                  style: TextStyle(
                    fontFamily: "Popins",
                    color: Get.theme.textSelectionTheme.selectionColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: frozenFund(
                    text: 'Preventing Frozen Fund',
                    data: Icons.wysiwyg,
                  ),
                ),
                textDot(
                  data:
                      'When transferring funds, please do not include any crypto related words such as: crypto C2C, BTC, USDT, ETH.',
                ),
                textDot(
                  data:
                      'When transferring funds, please do not include any crypto related words such as: crypto C2C, BTC, USDT, ETH.',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: frozenFund(
                    text: 'Preventing Frozen Fund',
                    data: Icons.wysiwyg,
                  ),
                ),
                textDot(
                  data:
                      'When transferring funds, please do not include any crypto related words such as: crypto C2C, BTC, USDT, ETH.',
                ),
                textDot(
                  data:
                      'When transferring funds, please do not include any crypto related words such as: crypto C2C, BTC, USDT, ETH.',
                ),
                moreText(text: 'Frozen Fund Handling'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: line(),
                ),
                Text(
                  'Frequently Asked Questions',
                  style: TextStyle(
                    fontFamily: "Popins",
                    color: Get.theme.textSelectionTheme.selectionColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: questionTile(question: 'How to prevent common scams?'),
                ),
                questionTile(question: 'How to prevent common scams?'),
                questionTile(question: 'How to prevent common scams?'),
                questionTile(question: 'How to prevent common scams?'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget viewPagerWidget({
    String header,
    String comment1,
    String comment2,
    String photoUrl = MyImgs.testPhoto,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(
              fontFamily: "Popins",
              color: Get.theme.textSelectionTheme.selectionColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Text(
              comment1,
              style: TextStyle(
                fontFamily: "Popins",
                color: Get.theme.textSelectionTheme.selectionColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Image.asset(
            photoUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            color: Get.theme.accentColor.withOpacity(0.1),
            child: Text(
              comment2,
              style: TextStyle(
                fontFamily: "Popins",
                color: Get.theme.textSelectionTheme.selectionColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget frozenFund({IconData data, String text}) {
    return Row(
      children: [
        Icon(
          data,
          size: 20,
          color: Get.theme.textSelectionTheme.selectionColor,
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          text,
          style: TextStyle(
            fontFamily: "Popins",
            color: Get.theme.textSelectionTheme.selectionColor,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget textDot({String data}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              right: 8.0,
            ),
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: Get.theme.hintColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Flexible(
            child: Text(
              data,
              style: TextStyle(
                fontFamily: "Popins",
                color: Get.theme.textSelectionTheme.selectionColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget line() {
    return Container(
      height: 0.5,
      width: double.infinity,
      color: Get.theme.hintColor,
    );
  }

  Widget moreText({String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Get.theme.accentColor,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Get.theme.accentColor,
              size: 15,
            ),
          ],
        ),
      ],
    );
  }
}
