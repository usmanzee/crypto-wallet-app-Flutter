import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuySellAppealProgressPage extends StatelessWidget {
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
          'Appeal Progress',
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
            child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              color: Get.theme.canvasColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: add teh current date and time here
                  Text(
                    '07 -30 15:17:20',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      color: Get.theme.hintColor,
                    ),
                  ),
                  Container(
                    color: Get.theme.scaffoldBackgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Get.theme.hintColor,
                              width: 0.3,
                            ),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned(
                                right: 0,
                                top: 0,
                                child: ClipPath(
                                  clipper: CustomTriangleClipper(),
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Get.theme.accentColor,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 16,
                                top: 6,
                                child: Text(
                                  'Appeal filed by user',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Get.theme.hintColor,
                              width: 0.3,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name of the user',
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  color: Get
                                      .theme.textSelectionTheme.selectionColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Reason(s)',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                    color: Get.theme.hintColor,
                                  ),
                                ),
                              ),
                              //todo: add a reason or multiple reasons here after discussion
                              Text(
                                'I received the payment from the buyer but the amount is incorrect.',
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                  color: Get
                                      .theme.textSelectionTheme.selectionColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                    color: Get.theme.hintColor,
                                  ),
                                ),
                              ),
                              //todo: add the description here after discussion
                              Text(
                                'Should be 400 CNY but I only receive 398',
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                  color: Get
                                      .theme.textSelectionTheme.selectionColor,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              //todo: add the multiple here... a kind of listview
                              Container(
                                height: 80,
                                padding: const EdgeInsets.all(0),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        child: Placeholder(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text(
                      'No more data',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Get.theme.textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16,),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Get.theme.hintColor,
                    width: 0.3,
                  ),
                ),
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Chat',
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
          )
        ],
      ),
    );
  }
}

class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
