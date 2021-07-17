import 'package:b4u_wallet/views/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeginnerTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: SingleChildScrollView(
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
              ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return videoTitle(
                    question: 'what is P2P Trading?',
                  );
                },
              ),
              Container(
                height: 0.5,
                width: double.infinity,
                color: Get.theme.hintColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Text(
                  'Frequently Asked Questions',
                  style: TextStyle(
                    fontFamily: "Popins",
                    color: Get.theme.textSelectionTheme.selectionColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              questionTile(
                question: 'Glossary of P2P trading terms',
                callback: () {},
              ),
              questionTile(
                question: 'Glossary of P2P trading terms',
                callback: () {},
              ),
              questionTile(
                question: 'Glossary of P2P trading terms',
                callback: () {},
              ),
              questionTile(
                question: 'Glossary of P2P trading terms',
                callback: () {},
              ),
              questionTile(
                question: 'Glossary of P2P trading terms',
                callback: () {},
              ),
              questionTile(
                question: 'Glossary of P2P trading terms',
                callback: () {},
              ),
              questionTile(
                question: 'Glossary of P2P trading terms',
                callback: () {},
              ),
              questionTile(
                question: 'Glossary of P2P trading terms',
                callback: () {},
              ),
              questionTile(
                question: 'Glossary of P2P trading terms',
                callback: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget videoTitle(
      {String minutes = '00',
      String seconds = '00',
      String question = '',
      String url}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            /*Image.asset(
              MyImgs.testPhoto,
              height: 100,
              width: double.infinity,
              fit: BoxFit.fill,
            ),*/
            Placeholder(
              fallbackHeight: 100,
              fallbackWidth: double.infinity,
              color: Colors.pink,
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        color: Colors.black,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      '$minutes:$seconds',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            question,
            style: TextStyle(
              fontFamily: "Popins",
              color: Get.theme.textSelectionTheme.selectionColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

}
