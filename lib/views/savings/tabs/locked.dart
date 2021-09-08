import 'package:b4u_wallet/controllers/savings_controller.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LockedTab extends StatelessWidget {
  final _savingsController = Get.find<SavingsController>();

  final singular = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Get.theme.canvasColor,
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: _savingsController.plansList.length,
                // itemCount: 4,
                itemBuilder: (context, index) {
                  return _savingsController.plansList[index].type
                              .toUpperCase() ==
                          'locked'.toUpperCase()
                      ? _container(
                          imageUrl: '',
                          index: index,
                          name: _savingsController.plansList[index].name,
                          rate: _savingsController.plansList[index].rate)
                      : Container();
                  // return _container(imageUrl: '',index: index,name: 'name',rate: '23.3');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _container({
    @required String imageUrl,
    @required int index,
    @required String name,
    @required String rate,
  }) {
    return Obx(
      () => Card(
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
                      // imageUrl,
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
                    border:
                        Border.all(color: Get.theme.canvasColor, width: 1.5),
                  ),
                  //todo: replace it with the server value
                  child: singular
                      ? Row(
                          children: [
                            Expanded(
                              child: _duration(
                                duration: 7,
                                index: index,
                                value: _savingsController.flexibleValues[index],
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
                                value: _savingsController.flexibleValues[index],
                              ),
                            ),
                            Expanded(
                              child: _duration(
                                duration: 14,
                                index: index,
                                value: _savingsController.flexibleValues[index],
                              ),
                            ),
                            Expanded(
                              child: _duration(
                                duration: 30,
                                index: index,
                                value: _savingsController.flexibleValues[index],
                              ),
                            ),
                            Expanded(
                              child: _duration(
                                duration: 90,
                                index: index,
                                value: _savingsController.flexibleValues[index],
                              ),
                            ),
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
                    rate,
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
      ),
    );
  }

  Widget _duration(
      {@required int duration, @required int index, @required int value}) {
    return GestureDetector(
      onTap: () {
        _savingsController.flexibleValues[index] = duration;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: _savingsController.flexibleValues[index] == duration
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
                color: _savingsController.flexibleValues[index] == duration
                    ? Get.theme.scaffoldBackgroundColor
                    : Get.theme.textSelectionTheme.selectionColor
                        .withOpacity(0.3)),
          ),
        ),
      ),
    );
  }
}
