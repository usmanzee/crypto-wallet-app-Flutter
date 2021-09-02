import 'package:b4u_wallet/views/widgets/dot_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pAdPostedPage extends StatelessWidget {
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
                    '11265608577223004160',
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
                                'Sell',
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
                                  'USDT',
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
                                'PKR',
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
                            'Rs',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                            ),
                          ),
                          Text(
                            '198.00',
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
                        second: '170.00 USDT',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: _textRow(
                          first: 'Limit',
                          second: '1500.000 - 150000.00 PKR',
                        ),
                      ),
                      Row(
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
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
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
