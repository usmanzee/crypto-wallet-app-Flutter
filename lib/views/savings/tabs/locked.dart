import 'package:b4u_wallet/controllers/savings_controller.dart';
import 'package:b4u_wallet/models/plans_model.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LockedTab extends StatefulWidget {
  final List<Plans> data;
  List<int> values=[7,7,7,7];
  LockedTab({@required this.data});

  @override
  _LockedTabState createState() => _LockedTabState();
}

class _LockedTabState extends State<LockedTab> {
  final singular = false;
  @override
  Widget build(BuildContext context) {
    // widget.values = List.filled(widget.data.length, 7);
    List<int> selectedSize = List.filled(widget.data.length, 7);
    return Scaffold(
      backgroundColor: Get.theme.canvasColor,
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: widget.data.length,
              itemBuilder: (context, index) {
                return widget.data[index].type == 'locked'
                    ? Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset(
                                MyImgs.testPhoto,
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.data[index].name,
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            'Duration',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Get.theme.textSelectionTheme.selectionColor
                                  .withOpacity(0.3),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Get.theme.canvasColor, width: 1.5),
                            ),
                            //todo: replace it with the server value
                            child: singular
                                ? Row(
                              children: [
                                Expanded(
                                  child: _duration(
                                    duration: 7,
                                    index: index,
                                    value: widget.values[index],
                                  ),
                                ),
                              ],
                            )
                                : Row(
                              children: [
                                Expanded(
                                    child: _duration(
                                      duration: 7,
                                      index: index,
                                      value: widget.values[index],
                                    )),
                                Expanded(
                                    child: _duration(
                                      duration: 14,
                                      index: index,
                                      value: widget.values[index],
                                    )),
                                Expanded(
                                    child: _duration(
                                      duration: 30,
                                      index: index,
                                      value: widget.values[index],
                                    )),
                                Expanded(
                                    child: _duration(
                                      duration: 90,
                                      index: index,
                                      value: widget.values[index],
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          child: Text(
                            'Annualized Interest Rate',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Get.theme.textSelectionTheme.selectionColor
                                  .withOpacity(0.3),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.data[index].rate,
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '%',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: GestureDetector(
                            onTap: () {
                              // todo: implement the callback here
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Get.theme.accentColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Subscribe',
                                  style: TextStyle(
                                    color: Get.theme.scaffoldBackgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _container({
    String name,
    bool singular,
    int index,
    int val,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    MyImgs.testPhoto,
                    height: 40,
                    width: 40,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Duration',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Get.theme.textSelectionTheme.selectionColor
                      .withOpacity(0.3),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Get.theme.canvasColor, width: 1.5),
                ),
                child: singular
                    ? Row(
                        children: [
                          Expanded(
                            child: _duration(
                              duration: 7,
                              index: index,
                              value: widget.values[index],
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                              child: _duration(
                            duration: 7,
                            index: index,
                            value: widget.values[index],
                          )),
                          Expanded(
                              child: _duration(
                            duration: 14,
                            index: index,
                            value: widget.values[index],
                          )),
                          Expanded(
                              child: _duration(
                            duration: 30,
                            index: index,
                            value: widget.values[index],
                          )),
                          Expanded(
                              child: _duration(
                            duration: 90,
                            index: index,
                            value: widget.values[index],
                          )),
                        ],
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Text(
                'Annualized Interest Rate',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Get.theme.textSelectionTheme.selectionColor
                      .withOpacity(0.3),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  '4.00',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '%',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: GestureDetector(
                onTap: () {
                  // todo: implement the callback here
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Get.theme.accentColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Subscribe',
                      style: TextStyle(
                        color: Get.theme.scaffoldBackgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _duration(
      {@required int duration, @required int index, @required int value}) {
    return GestureDetector(
      onTap: () {
        widget.values[index] = duration;
        setState(() {});
        // print('from index ${values[index]}');
        print(widget.values.reversed);
        // print(duration);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: widget.values[index] == duration
              ? Get.theme.accentColor
              : Get.theme.scaffoldBackgroundColor,
        ),
        child: Center(
          child: Text(
            '$duration Days',
            style: TextStyle(
                fontFamily: "Popins",
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: widget.values[index] == duration ? Get.theme.scaffoldBackgroundColor: Get.theme.textSelectionTheme.selectionColor
                    .withOpacity(0.3)),
          ),
        ),
      ),
    );
  }
}
