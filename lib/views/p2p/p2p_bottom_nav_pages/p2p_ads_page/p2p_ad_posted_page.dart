import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/widgets/dot_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pAdPostedPage extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();

  //todo: add the variables here for the values of the variables
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.greenAccent,
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Successfully Posted',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w600,
                            fontSize: 22.0,
                            color: Colors.greenAccent,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Your ad has been published and is now visible to other users once it goes online. Please pay attention to prompts for new orders.',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Get.theme.textSelectionTheme.selectionColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CustomPaint(
                  painter: DashedLinePainter(),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ad Number',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      color: Get.theme.hintColor,
                    ),
                  ),
                  //todo: add the order number here for the user to see
                  Text(
                  _p2pController.p2pOfferAddResponse.id.toString(),
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      color: Get.theme.textSelectionTheme.selectionColor,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Get.theme.canvasColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                _p2pController.p2pOfferAddResponse.side,
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  color: Colors.redAccent,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  _p2pController.p2pOfferAddResponse.quoteUnit,
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                              ),
                              Text(
                                'With',
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  color: Get.theme.hintColor,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                _p2pController.p2pOfferAddResponse.baseUnit,
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  color: Get
                                      .theme.textSelectionTheme.selectionColor,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Get.theme.hintColor,
                          ),
                        ],
                      ), // todo: add the values here for the variables
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _p2pController.p2pOfferAddResponse.baseUnit,
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                            ),
                          ),
                          Text(
                            _p2pController.p2pOfferAddResponse.price,
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _textRow(
                        first: 'Total',
                        second:
                            '${_p2pController.p2pOfferAddResponse.availableAmount} ${_p2pController.p2pOfferAddResponse.quoteUnit}',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: _textRow(
                          first: 'Limit',
                          second:
                              '${_p2pController.p2pOfferAddResponse.minOrderAmount} - ${_p2pController.p2pOfferAddResponse.maxOrderAmount} ${_p2pController.p2pOfferAddResponse.baseUnit}',
                        ),
                      ),
                      //todo: maybe after discussion we can add here the variables
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'EasyPaisa-PK Only',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Get.theme.hintColor,
                            ),
                          ),
                        ],
                      ),*/
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()async{
                  _p2pController.resetOfferAddVariables();
                  Get.back();
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Get.theme.accentColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        color: Get.theme.scaffoldBackgroundColor,
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

  Widget _textRow({@required String first, @required second}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          first,
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            color: Get.theme.hintColor,
          ),
        ),
        Text(
          second,
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
      ],
    );
  }
}
