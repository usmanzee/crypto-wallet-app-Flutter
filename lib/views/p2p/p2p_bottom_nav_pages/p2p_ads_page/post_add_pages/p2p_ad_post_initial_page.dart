import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/models/p2p_add_offer_model.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page/post_add_pages/pages/post_add_first_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page/post_add_pages/pages/post_add_second_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page/post_add_pages/pages/post_add_third_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pAdPostInitialPage extends StatelessWidget {
  final _pageController = PageController(initialPage: 0);
  final _p2pController = Get.find<P2pController>();

  final _pages = [PostAddFirstPage(), PostAddSecondPage(), PostAddThirdPage()];

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
          'Post Normal Ad',
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
            _p2pController.secondPage.value = false;
            // _p2pController.secondShowReservedFee.value = false;
            _p2pController.thirdPage.value = false;
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: Get.theme.hintColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.book_outlined,
              size: 20,
              color: Get.theme.hintColor,
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                '1/3. Set Type & Price',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _pageIndicator(
                    enabled: true,
                    number: 1,
                  ),
                  _indicatorBar(enabled: _p2pController.secondPage.value),
                  _pageIndicator(
                    enabled: _p2pController.secondPage.value,
                    number: 2,
                  ),
                  _indicatorBar(enabled: _p2pController.thirdPage.value),
                  _pageIndicator(
                    enabled: _p2pController.thirdPage.value,
                    number: 3,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                decoration: BoxDecoration(
                  color: Get.theme.canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {},
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _pages[index];
                  },
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /*_p2pController.secondShowReservedFee.value
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color:
                              Get.theme.colorScheme.secondary.withOpacity(0.3),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Reserved Fee:',
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Get.theme.hintColor,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                Icons.info_outline,
                                size: 20,
                                color: Get.theme.hintColor,
                              ),
                            ),
                            Text(
                              '${_p2pController.secondReservedFee.value} ${_p2pController.firstSelectedAsset.value}',
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color:
                                    Get.theme.textSelectionTheme.selectionColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),*/
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _p2pController.secondPage.value
                          ? Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (_pageController.page == 1) {
                                          _pageController.previousPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.linear,
                                          );
                                          _p2pController.secondPage.value =
                                              false;
                                          // _p2pController.secondShowReservedFee
                                          //     .value = false;
                                        }
                                        if (_pageController.page == 2) {
                                          _pageController.previousPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.linear,
                                          );
                                          _p2pController.thirdPage.value =
                                              false;
                                          // _p2pController.secondShowReservedFee
                                          //     .value = true;
                                        }
                                      },
                                      child: Container(
                                        // width: Get.width,
                                        decoration: BoxDecoration(
                                          color: Get.theme.accentColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Center(
                                          child: Text(
                                            'Previous',
                                            style: TextStyle(
                                              fontFamily: "Popins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: Get.theme
                                                  .scaffoldBackgroundColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      Expanded(
                        flex: 7,
                        child: GestureDetector(
                          onTap: _p2pController.thirdPage.value
                              ? () async {
                                  List<Map<String, String>> map =
                                      <Map<String, String>>[];
                                  _p2pController.selectedMethodForOffer
                                      .forEach((element) {
                                    map.add({"name": "${element.slug}"});
                                  });
                                  final model = P2pAddOfferModel(
                                    originAmount: double.parse(_p2pController
                                        .secondTotalAmountTextController.text),
                                    // price handling
                                    price: _p2pController
                                                .firstFixedFloating.value
                                                .toLowerCase() ==
                                            'fixed'
                                        ? double.parse(_p2pController
                                            .firstFixedPrice.value)
                                        : 0.00,
                                    baseUnit:
                                        _p2pController.firstSelectedFiat.value,
                                    quoteUnit:
                                        _p2pController.firstSelectedAsset.value,
                                    minOrderAmount: double.parse(_p2pController
                                        .secondOrderLimitFirstController.text),
                                    maxOrderAmount: double.parse(_p2pController
                                        .secondOrderLimitSecondController.text),
                                    side: _p2pController.firstBuySell.value
                                        .toLowerCase(),
                                    timeLimit:
                                        _p2pController.secondTimeLimitInt.value,
                                    note: _p2pController
                                        .thirdTermsController.text,
                                    autoReply: _p2pController
                                        .thirdAutoReplyController.text,
                                    //margin handling
                                    margin: _p2pController
                                                .firstFixedFloating.value
                                                .toLowerCase() ==
                                            'fixed'
                                        ? 0
                                        : double.parse(_p2pController
                                            .firstFloatingPrice.value),
                                  );
                                  var body = model.toJson();
                                  // adding the array of maps a as a variable in the field
                                  body['payment_methods'] = map;
                                  final res = await _p2pController.addP2pOffer(
                                      body: body);
                                  if (res) {
                                    Get.toNamed('/p2p_ad_posted_page');
                                  } else {
                                    print('not added');
                                  }
                                }
                              : () {
                                  if (_pageController.page == 0) {
                                    if (double.parse(_p2pController
                                            .firstFixedPrice.value) >=
                                        double.parse(_p2pController
                                            .firstLowestPrize.value)) {
                                      _pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.linear,
                                      );
                                      _p2pController.secondPage.value = true;
                                      // _p2pController.secondShowReservedFee.value =
                                      //     true;
                                      _p2pController.firstShowWarning.value =
                                          false;
                                    } else {
                                      _p2pController.firstShowWarning.value =
                                          true;
                                    }
                                  }
                                  if (_pageController.page == 1) {
                                    if (_p2pController
                                        .secondFormKey.currentState
                                        .validate()) {
                                      if (_p2pController
                                              .selectedMethodForOffer.length >
                                          0) {
                                        _pageController.nextPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear,
                                        );
                                        _p2pController.thirdPage.value = true;
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Please select a payment method'),
                                          ),
                                        );
                                      }
                                    }
                                    // _p2pController.secondShowReservedFee.value =
                                    //     false;
                                  }
                                },
                          child: Container(
                            // width: Get.width,
                            decoration: BoxDecoration(
                              color: Get.theme.accentColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                _p2pController.thirdPage.value
                                    ? 'Post'
                                    : 'Next',
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Get.theme.scaffoldBackgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageIndicator({@required bool enabled, @required int number}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: enabled ? Get.theme.accentColor : Get.theme.canvasColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            color: enabled
                ? Get.theme.scaffoldBackgroundColor
                : Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
      ),
    );
  }

  Widget _indicatorBar({@required bool enabled}) {
    return Expanded(
      child: Container(
        height: 8,
        color: enabled
            ? Get.theme.accentColor.withOpacity(0.5)
            : Get.theme.canvasColor,
      ),
    );
  }
}
