import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostAddThirdPage extends StatelessWidget {
/*  final _registeredDaysController = TextEditingController(text: '0');
  final _btcHoldingController = TextEditingController(text: '0.01');*/
  final _p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _container(
                    heading: 'Terms (Optional)',
                    controller: _p2pController.thirdTermsController,
                  ),
                  _container(
                    heading: 'Auto-replay (Optional)',
                    controller: _p2pController.thirdAutoReplyController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: 2,
                width: double.infinity,
                color: Get.theme.hintColor,
              ),
            ),
            /* Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Counterparty Conditions',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Get.theme.hintColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'adding counterparty requirements will reduce the exposure of your Ad',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Get.theme.hintColor,
                        ),
                      ),
                    ),
                    //todo: this option will be enabled by default
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Get.theme.accentColor.withOpacity(0.4),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Complete KYC',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Get.theme.textSelectionTheme.selectionColor,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () => _p2pController.thirdRegisteredDays.value =
                            !_p2pController.thirdRegisteredDays.value,
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 20,
                              color: _p2pController.thirdRegisteredDays.value
                                  ? Get.theme.accentColor
                                  : Get.theme.hintColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Registered ',
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color:
                                    Get.theme.textSelectionTheme.selectionColor,
                              ),
                            ),
                            Container(
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: Get.theme.scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              width: 56,
                              child: TextFormField(
                                controller: _registeredDaysController,
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: Get
                                      .theme.textSelectionTheme.selectionColor,
                                ),
                                maxLines: 1,
                                maxLength: 4,
                                decoration: InputDecoration(
                                  counterText: "",
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Text(
                              ' Day[s] ago',
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color:
                                    Get.theme.textSelectionTheme.selectionColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _p2pController.thirdBtc.value =
                          !_p2pController.thirdBtc.value,
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 20,
                            color: _p2pController.thirdBtc.value
                                ? Get.theme.accentColor
                                : Get.theme.hintColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Holdings more than ',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                            ),
                          ),
                          Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                                color: Get.theme.scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(2)),
                            width: 56,
                            child: TextFormField(
                              controller: _btcHoldingController,
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color:
                                    Get.theme.textSelectionTheme.selectionColor,
                              ),
                              maxLines: 1,
                              maxLength: 4,
                              decoration: InputDecoration(
                                counterText: "",
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Text(
                            ' BTC',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  height: 2,
                  width: double.infinity,
                  color: Get.theme.hintColor,
                ),
              ),
              _radioButton(
                value: 1,
                title: 'Online',
                groupValue: _p2pController.thirdOnlineOffline.value,
              ),
              _radioButton(
                  value: 2,
                  title: 'Offline now. Publish manually later.',
                  groupValue: _p2pController.thirdOnlineOffline.value),*/
          ],
        ),
      ),
    );
  }

  Widget _container({
    @required String heading,
    @required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
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
        Container(
          decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            controller: controller,
            maxLines: 4,
            maxLength: 1000,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

/*Widget _radioButton(
      {@required int value, @required int groupValue, @required String title}) {
    return ListTile(
      onTap: (){
        _p2pController.thirdOnlineOffline.value = value;
      },
      leading: Radio(
        value: value,
        groupValue: groupValue,
        onChanged: (value) {
          _p2pController.thirdOnlineOffline.value = value;
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Popins",
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          color: Get.theme.textSelectionTheme.selectionColor,
        ),
      ),
    );
  }*/
}
