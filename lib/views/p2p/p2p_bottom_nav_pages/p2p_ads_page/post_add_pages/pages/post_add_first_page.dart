import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/widgets/line_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostAddFirstPage extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buySellContainer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          dropDownWidget(
                            title: 'Asset',
                            items: _p2pController.firstAssetList.value,
                            selectedValue: _p2pController.firstSelectedAsset,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          dropDownWidget(
                            title: 'With Fiat',
                            items: _p2pController.firstAssetList.value,
                            selectedValue: _p2pController.firstSelectedFiat,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 2,
                color: Get.theme.hintColor,
                width: double.infinity,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Settings',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Get.theme.textSelectionTheme.selectionColor,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    lineWidget(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Type',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Get.theme.hintColor,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    _fixedFloatingContainer(),
                    const SizedBox(
                      height: 16,
                    ),
                    //todo: add the widgets here which can be swapped
                    _p2pController.firstFixedFloating.value == 'Fixed'
                        ? _fixedWidget()
                        : _floatingWidget(context: context),
                  ],
                ),
              ),
              lineWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buySellContainer() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          _containerWidget(text: 'Buy'),
          const SizedBox(
            width: 4,
          ),
          _containerWidget(text: 'Sell'),
        ],
      ),
    );
  }

  Widget _fixedFloatingContainer() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          _containerTypeWidget(text: 'Fixed'),
          const SizedBox(
            width: 4,
          ),
          _containerTypeWidget(text: 'Floating'),
        ],
      ),
    );
  }

  Widget _containerWidget({@required String text}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _p2pController.firstBuySell.value = text,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: _p2pController.firstBuySell.value == text
                  ? Get.theme.accentColor
                  : Get.theme.scaffoldBackgroundColor),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: _p2pController.firstBuySell.value == text
                    ? Get.theme.scaffoldBackgroundColor
                    : Get.theme.textSelectionTheme.selectionColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _containerTypeWidget({@required String text}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _p2pController.firstFixedFloating.value = text,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: _p2pController.firstFixedFloating.value == text
                  ? Get.theme.accentColor
                  : Get.theme.scaffoldBackgroundColor),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: _p2pController.firstFixedFloating.value == text
                    ? Get.theme.scaffoldBackgroundColor
                    : Get.theme.textSelectionTheme.selectionColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownWidget(
      {@required String title,
      @required List<String> items,
      @required RxString selectedValue}) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Get.theme.hintColor,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Get.theme.hintColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: DropdownButton(
              dropdownColor: Get.theme.scaffoldBackgroundColor,
              elevation: 0,
              isDense: true,
              // itemHeight: 100,
              isExpanded: true,
              underline: Container(
                color: Get.theme.scaffoldBackgroundColor,
              ),
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Get.theme.textSelectionTheme.selectionColor,
              ),
              // itemHeight: 60,
              value: selectedValue.value,
              icon: Icon(
                Icons.arrow_drop_down,
                size: 30,
              ),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                      color: Get.theme.textSelectionTheme.selectionColor,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                selectedValue.value = value;
                _p2pController.fetchExchangeRateForSingleAsset();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _fixedWidget() {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fixed',
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Get.theme.hintColor,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                    color: Get.theme.hintColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      //todo: add code for decreasing by one
                      InkWell(
                        onTap: () {
                          if (double.parse(
                                  _p2pController.firstFixedPrice.value) ==
                              double.parse(
                                  _p2pController.firstLowestPrize.value)) {
                            return;
                          } else {
                            final val = _p2pController.firstFixedPrice.value =
                                (double.parse(_p2pController
                                            .fixedTextController.text) -
                                        1)
                                    .toString();
                            _p2pController.fixedTextController.text =
                                val.toString();
                          }
                        },
                        child: Icon(
                          Icons.remove,
                          size: 20,
                          color: Get.theme.canvasColor,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _p2pController.fixedTextController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Get.theme.scaffoldBackgroundColor,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      //todo: add code for increasing by one
                      InkWell(
                        onTap: () {
                          final val = _p2pController
                              .firstFixedPrice.value = (double.parse(
                                      _p2pController.fixedTextController.text) +
                                  1)
                              .toString();
                          _p2pController.fixedTextController.text = val;
                        },
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Get.theme.canvasColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
            ],
          ),
          _p2pController.firstShowWarning.value
              ? Text(
                  'Please add a valid value',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: Colors.redAccent,
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Text(
                  'Lowest Order Prize',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: Get.theme.hintColor,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                //todo: add the callback here for the dialog and the values
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: Get.theme.hintColor,
                ),
              ],
            ),
          ),
          //todo: change the currency name with respect to the currency selected
          Text(
            '${_p2pController.firstSelectedFiat} ${_p2pController.firstLowestPrize}',
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              color: Get.theme.textSelectionTheme.selectionColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingWidget({@required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Floating Price Margin',
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Get.theme.hintColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Floating Price Margin',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Floating Price = Market Price * Currency * Floating Price Adjustment',
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color:
                                    Get.theme.textSelectionTheme.selectionColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Get.theme.accentColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Center(
                                child: Text(
                                  'OK',
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
                        ],
                      ),
                    );
                  },
                );
              },
              child: Icon(
                Icons.info_outline,
                size: 20,
                color: Get.theme.hintColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                  color: Get.theme.hintColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    //todo: add code for decreasing by one
                    GestureDetector(
                      onTap: () {
                        if (double.parse(
                                _p2pController.firstFloatingPrice.value) ==
                            80.0) {
                          return;
                        } else {
                          final val = _p2pController.firstFloatingPrice.value =
                              (double.parse(_p2pController
                                          .floatingTextController.text) -
                                      1)
                                  .toString();
                          _p2pController.floatingTextController.text = val;
                        }
                      },
                      child: Icon(
                        Icons.remove,
                        size: 20,
                        color: Get.theme.canvasColor,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _p2pController.floatingTextController,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Get.theme.scaffoldBackgroundColor,
                        ),
                        onChanged: (value) {
                          _p2pController.firstFloatingPrice.value = value;
                          // print(_p2pController.firstFloatingPrice.value);
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: '80.0-120.0',
                          hintStyle: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Get.theme.canvasColor,
                          ),
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                      ),
                    ),
                    Text(
                      '%',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: Get.theme.scaffoldBackgroundColor,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    //todo: add code for increasing by one
                    GestureDetector(
                      onTap: () {
                        if (double.parse(
                                _p2pController.firstFloatingPrice.value) ==
                            120.0) {
                          return;
                        } else {
                          final val = _p2pController.firstFloatingPrice.value =
                              (double.parse(_p2pController
                                          .floatingTextController.text) +
                                      1)
                                  .toString();
                          _p2pController.floatingTextController.text = val;
                        }
                      },
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: Get.theme.canvasColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Price',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      color: Get.theme.hintColor,
                    ),
                  ),
                  //vales are being multiplied here
                  Text(
                    '${(_p2pController.firstLowestOnePercent.value * double.parse(_p2pController.firstFloatingPrice.value)).toPrecision(8)} ${_p2pController.firstSelectedFiat.value}',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Get.theme.textSelectionTheme.selectionColor,
                    ),
                  ),
                ],
              ),
              //maybe for later use in the app
              /*Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'Highest Order Prize',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Get.theme.hintColor,
                        ),
                      ),
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Get.theme.hintColor,
                      ),
                    ],
                  ),
                  Text(
                    '${_p2pController.firstSelectedFiat.value}${_p2pController.firstLowestOnePercent.value}',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Get.theme.textSelectionTheme.selectionColor,
                    ),
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ],
    );
  }
}
