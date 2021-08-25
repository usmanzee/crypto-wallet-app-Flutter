import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuySellAppealPage extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();
  int a = 0;
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
          'Appeal',
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
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Get.theme.accentColor.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        _textWidget(
                          text:
                              'Reason for appeal and proofs are visible to both parties and CS. Please avoid including any private or sensitive info',
                          heading: '1',
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        _textWidget(
                          heading: '2',
                          text:
                              'Baseless appeal request can result in banning of the account.',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Reasons foe Appeal (Mandatory)',
                      style: TextStyle(
                        color: Get.theme.hintColor,
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  //todo: add the reason menu here after discussion
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: Colors.black,
                        border: Border.all(
                          color: Get.theme.hintColor,
                          width: 0.3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Things will be added here after discussion',
                          style: TextStyle(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Description',
                      style: TextStyle(
                        color: Get.theme.hintColor,
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Get.theme.hintColor,
                          width: 0.3,
                        ),
                      ),
                      //todo: add the controller here for the text value.
                      child: TextFormField(
                        maxLines: 6,
                        maxLength: 500,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 8,
                    ),
                    child: Text(
                      'Upload Proof (Mandatory)',
                      style: TextStyle(
                        color: Get.theme.hintColor,
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Screenshot, recording, documents of payment and communication log, Size < 5MB',
                      style: TextStyle(
                        color: Get.theme.hintColor,
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w400,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                  //todo: on the click of it add the photos
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(
                        () => Row(
                          children: [
                            Row(
                              children: _p2pController.a,
                            ),
                            GestureDetector(
                              onTap: () {
                                print(_p2pController.a.length);
                                _p2pController.a.add(
                                  _photoWidget(
                                    photoPath: 'nothing',
                                    index: a++,
                                  ),
                                );
                              },
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Get.theme.canvasColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 25,
                                    color: Get.theme.hintColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => _p2pController.a.clear(),
                              child: Text(
                                'Name',
                                style: TextStyle(),
                              ),
                            ),
                            Text(
                              'Name of the person',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 0.3,
                          width: double.infinity,
                          color: Get.theme.hintColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone',
                              style: TextStyle(),
                            ),
                            Text(
                              'Phone number here',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 0.3,
                          width: double.infinity,
                          color: Get.theme.hintColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: GestureDetector(
                onTap: () => Get.toNamed('/p2p_buy_sell_appeal_pending_page'),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Get.theme.accentColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      'Appeal',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Get.theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textWidget({
    @required String heading,
    @required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$heading.',
          style: TextStyle(),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(),
          ),
        ),
      ],
    );
  }

  Widget _photoWidget({@required String photoPath, @required int index}) {
    return Padding(
      key: ValueKey(index),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Get.theme.canvasColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          children: [
            Placeholder(
              color: Get.theme.accentColor,
            ),
            Center(
              child: Text(
                '$index',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                ),
              ),
            ),
            Positioned(
              right: 4,
              top: 4,
              child: GestureDetector(
                onTap: () {
                  _p2pController.a.removeWhere(
                      (element) => element.key.toString() == '[<$index>]');
                },
                child: Icon(
                  Icons.close,
                  size: 15,
                  color: Get.theme.hintColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
