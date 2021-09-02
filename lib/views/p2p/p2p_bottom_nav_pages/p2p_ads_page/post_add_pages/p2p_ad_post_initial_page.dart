import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pAdPostInitialPage extends StatelessWidget {
  final mPageController = PageController(initialPage: 0);

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
          onTap: () => Get.back(),
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
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.blueGrey,
          ),
          Expanded(
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: mPageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {},
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                    child: Text('$index'),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: GestureDetector(
              onTap: () {
                return mPageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Get.theme.accentColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    'Next',
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
    );
  }
}
