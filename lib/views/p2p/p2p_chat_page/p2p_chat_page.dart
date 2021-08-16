import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class P2pChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.close,
            size: 25,
            color: Get.theme.hintColor,
          ),
        ),
        //todo: add the required variables here
        title: Padding(
          padding: const EdgeInsets.only(right: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Get.theme.accentColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'R',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Get.theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Get.theme.canvasColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      height: 4,
                      width: 4,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'rana traders'.toUpperCase(),
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          //todo: add the required variables here
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '12:55',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Get.theme.textSelectionTheme.selectionColor,
                      ),
                    ),
                    Text(
                      'Amount',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: Get.theme.hintColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                //todo: add the required variables here
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Unpaid',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Get.theme.textSelectionTheme.selectionColor,
                      ),
                    ),
                    Text(
                      'Rs 11,651.50',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Get.theme.textSelectionTheme.selectionColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8,)
              ],
            ),
          ),
          // the elevated line here
          Card(
            elevation: 3,
            child: Container(
              height: 0.6,
              width: double.infinity,
              color: Get.theme.canvasColor,
            ),
          ),
          Expanded(
            child: Container(
              color: Get.theme.canvasColor,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                reverse: true,
                itemBuilder: (context, index) {
                  return _chatWidget(
                      message: 'how are you',
                      nameLetter: 'R',
                      user: index % 2 == 0 ? true : false);
                },
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Get.theme.canvasColor,
        ),
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          // top: 8,
        ),
        child: Card(
          elevation: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: Get.theme.scaffoldBackgroundColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        //todo: add the controller here and test it on the live server data
                        child: TextFormField(
                          textInputAction: TextInputAction.send,
                          onFieldSubmitted: (a) {
                            print('hi');
                          },
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Get.theme.textSelectionTheme.selectionColor,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Please enter content here',
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(top: 10),
                            hintStyle: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: Get.theme.hintColor,
                            ),
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 25,
                    color: Get.theme.hintColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chatWidget({
    @required String nameLetter,
    @required String message,
    bool user = false,
  }) =>
      user
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Get.theme.accentColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      nameLetter,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Get.theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Container(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Get.theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          message,
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Get.theme.textSelectionTheme.selectionColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Container(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Get.theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          message,
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Get.theme.textSelectionTheme.selectionColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Get.theme.accentColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      nameLetter,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Get.theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
}
