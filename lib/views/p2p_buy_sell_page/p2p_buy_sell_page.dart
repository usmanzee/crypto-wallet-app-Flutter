import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuySellPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16,),
                    decoration: BoxDecoration(
                      color: Get.theme.accentColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_ios,size: 20,color: Get.theme.scaffoldBackgroundColor,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8,),
                              child: Text('P2P'),
                            ),
                            Icon(Icons.arrow_drop_down,size: 20,),
                          ],
                        ),
                        Row(
                          children: [
                            Text('UAH',),
                            Icon(Icons.swap_horiz,size: 20,),
                            Icon(Icons.keyboard_control,size: 20,),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
