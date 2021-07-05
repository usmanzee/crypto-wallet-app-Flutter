import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuySellPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
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
                            Text('P2P'),
                            Icon(Icons.arrow_drop_down,size: 15,),
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
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
