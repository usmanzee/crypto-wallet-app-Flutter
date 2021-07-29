import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCurrencyP2pScreen extends StatelessWidget {
  final P2pController _p2pController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Currency',
          style: TextStyle(color: Get.theme.hintColor),
        ),
        centerTitle: true,
        backwardsCompatibility: false,
        elevation: 0,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Get.theme.hintColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Get.theme.canvasColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 20,
                    color: Get.theme.hintColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Please enter currency here',
                    style: TextStyle(color: Get.theme.hintColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ListView.builder(
                    physics: ScrollPhysics(),
                    controller: _p2pController.scrollController,
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          //todo: add the call here and change the variable in teh controller to change the value of the lists.
                        },
                        child: _row(
                            currencyName: 'ARS',
                            type: 'ARS',
                            currencySymbol: '\$',
                            icon: true),
                      );
                    },
                  ),
                  Obx(
                    () => _p2pController.showTopButton.value
                        ? Positioned(
                            bottom: 32,
                            right: 16,
                            child: GestureDetector(
                              onTap: ()=> _p2pController.scrollController.animateTo(00, duration: Duration(milliseconds: 300), curve: Curves.easeIn),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Get.theme.hintColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(Icons.arrow_upward,size: 35,color: Get.theme.scaffoldBackgroundColor,),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(
      {String currencyName, String currencySymbol, String type, bool icon}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    '\$ARS',
                    style: TextStyle(color: Get.theme.hintColor),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    children: [
                      Text(currencyName),
                    ],
                  ),
                ],
              ),
              icon
                  ? Icon(
                      Icons.check,
                      size: 20,
                      color: Get.theme.accentColor,
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            margin: const EdgeInsets.only(left: 50),
            height: 0.3,
            width: Get.size.width,
            color: Get.theme.hintColor,
          ),
        ],
      ),
    );
  }
}
