import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pAdsPage extends StatelessWidget {
  // final _p2pController = Get.find<P2pController>();
  final RxString _selectedElement = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: Get.theme.hintColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          'My Ads',
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Get.theme.hintColor,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed('/p2p_ads_page_level_check_page'),
            child: Icon(
              Icons.add,
              size: 25,
              color: Get.theme.hintColor,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () => Get.toNamed('/p2p_ads_page_history_page'),
            child: Icon(
              Icons.history,
              size: 25,
              color: Get.theme.hintColor,
            ),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _element(
                  callback: () {
                    _selectedElement.value = 'Cryptos';
                    _showDialog(context: context);
                  },
                  name: 'Cryptos',
                ),
                _element(
                  callback: () {
                    _selectedElement.value = 'Types';
                    _showDialog(context: context);
                  },
                  name: 'Types',
                ),
                _element(
                  callback: () {
                    _selectedElement.value = 'Status';
                    _showDialog(context: context);
                  },
                  name: 'Status',
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: Get.theme.canvasColor,
          ),
          //todo: remove it when there will be some proper data
          SizedBox(
            height: 100,
          ),
          //todo: add the picture here
          Container(
            width: 100,
            child: Placeholder(
              fallbackHeight: 100,
              fallbackWidth: 50,
              strokeWidth: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'You do not have any Ads.',
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: Get.theme.hintColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed('/p2p_ads_page_level_check_page'),
            child: Container(
              decoration: BoxDecoration(
                color: Get.theme.accentColor,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Text(
                'Post Ad',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Get.theme.scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _element({
    @required String name,
    Function callback,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: _selectedElement.value == name
                  ? Get.theme.accentColor
                  : Get.theme.textSelectionTheme.selectionColor,
            ),
          ),
          Icon(
            _selectedElement.value == name
                ? Icons.arrow_drop_up
                : Icons.arrow_drop_down,
            size: 15,
            color: _selectedElement.value == name
                ? Get.theme.accentColor
                : Get.theme.hintColor,
          ),
        ],
      ),
    );
  }

  void _showDialog({
    @required BuildContext context,
  }) {
    showDialog(
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 56),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0.5,
              backwardsCompatibility: false,
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              foregroundColor: Get.theme.textSelectionTheme.selectionColor,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20,
                  color: Get.theme.hintColor,
                ),
              ),
              centerTitle: true,
              title: Text(
                'My Ads',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Get.theme.hintColor,
                ),
              ),
              actions: [
                GestureDetector(
                  child: Icon(
                    Icons.add,
                    size: 25,
                    color: Get.theme.hintColor,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.history,
                    size: 25,
                    color: Get.theme.hintColor,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Obx(
                    () => Container(
                      color: Get.theme.scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _element(
                            name: 'Cryptos',
                          ),
                          _element(
                            name: 'Types',
                          ),
                          _element(
                            name: 'Status',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 0.5,
                  width: double.infinity,
                  color: Get.theme.canvasColor,
                ),
                Flexible(
                  child: Container(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        print('from listview');
                        Get.back();
                      },
                      child: ListView.builder(
                        itemCount: 100,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          //todo: add the variables here and also add the other functionality
                          return _listWidget();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _listWidget({String name, Function callback}) {
    return GestureDetector(
      onTap: () {
        print('from items');
      },
      child: Container(
        color: Get.theme.scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Get.theme.hintColor,
                      ),
                    ),
                    //todo: add the condition here for the done marker
                    Icon(
                      Icons.done,
                      color: Get.theme.accentColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.5,
                width: double.infinity,
                color: Get.theme.hintColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
