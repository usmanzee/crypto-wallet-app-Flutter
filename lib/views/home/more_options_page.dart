import 'package:b4u_wallet/controllers/transfer_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/views/transfer/transfer_page.dart';
import 'package:b4u_wallet/views/wallet/wallet_p2p_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/controllers/HomeController.dart';

class MoreOptionsPage extends StatelessWidget {
  List<Widget> listOfWidgetsCommonFunctions = List.empty(growable: true);
  List<Widget> listOfWidgetsTrade = List.empty(growable: true);
  List<Widget> listOfWidgetsFinance = List.empty(growable: true);
  List<Widget> listOfWidgetsOthers = List.empty(growable: true);
  final HomeController homeController = Get.find();
  final con =Get.put(WalletController());
  final con2 = Get.put(TransferController());

  @override
  Widget build(BuildContext context) {
    listOfWidgetsTrade.add(_linksCard(
        icon: Icons.credit_card,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsTrade.add(_linksCard(
        icon: Icons.credit_card,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsTrade.add(_linksCard(
        icon: Icons.credit_card,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsTrade.add(_linksCard(
        icon: Icons.credit_card,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsTrade.add(_linksCard(
        icon: Icons.credit_card,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsTrade.add(_linksCard(
        icon: Icons.credit_card,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsTrade.add(_linksCard(
        icon: Icons.credit_card,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsFinance.add(_linksCard(
        icon: Icons.account_balance_sharp,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsFinance.add(_linksCard(
        icon: Icons.account_balance_sharp,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsFinance.add(_linksCard(
        icon: Icons.account_balance_sharp,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsFinance.add(_linksCard(
        icon: Icons.account_balance_sharp,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsFinance.add(_linksCard(
        icon: Icons.account_balance_sharp,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsFinance.add(_linksCard(
        icon: Icons.account_balance_sharp,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsFinance.add(_linksCard(
        icon: Icons.account_balance_sharp,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsFinance.add(_linksCard(
        icon: Icons.account_balance_sharp,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsFinance.add(_linksCard(
        icon: Icons.account_balance_sharp,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsFinance.add(_linksCard(
        icon: Icons.account_balance_sharp,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsFinance.add(_linksCard(
        icon: Icons.account_balance_sharp,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    listOfWidgetsOthers.add(_linksCard(
        icon: Icons.text_rotation_angledown,
        name: 'heading head',
        onPressed: () {},
        context: context));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        centerTitle: true,
        title: Text(
          'Services',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backwardsCompatibility: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headingWidget(heading: 'Common Functions'),
              Wrap(
                runSpacing: 20,
                spacing: 20,
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: [
                  _linksCard(
                      context: context,
                      icon: Icons.vertical_align_bottom,
                      onPressed: () {
                        //todo: before coming to this page select the default currency
                       Get.toNamed('/transfer_page');
                      },
                      name: 'Transfer'),
                  _linksCard(
                      context: context,
                      icon: Icons.vertical_align_top,
                      onPressed: () {
                        homeController.isLoggedIn.value
                            ? Get.toNamed('/wallets-search',
                                arguments: {'searchFrom': 'withdraw'})
                            : Get.toNamed('/login');
                      },
                      name: "home.screen.link.card.withdraw".tr),
                  _linksCard(
                      context: context,
                      icon: Icons.swap_horiz,
                      onPressed: () {
                        homeController.isLoggedIn.value
                            ? homeController.selectedNavIndex = 3
                            : Get.toNamed('/login');
                      },
                      name: "home.screen.link.card.buy_sell".tr),
                  _linksCard(
                      context: context,
                      icon: Icons.insights,
                      onPressed: () {
                        homeController.selectedNavIndex = 2;
                      },
                      name: "home.screen.link.card.trade".tr),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              _headingWidget(heading: 'Trade'),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: listOfWidgetsTrade,
              ),
              SizedBox(
                height: 26,
              ),
              _headingWidget(heading: 'Finance'),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: listOfWidgetsFinance,
              ),
              SizedBox(
                height: 26,
              ),
              _headingWidget(heading: 'Others'),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: listOfWidgetsOthers,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headingWidget({@required String heading}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: double.infinity,
            height: 0.1,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
      ],
    );
  }

  Widget _linksCard(
      {context, IconData icon, VoidCallback onPressed, String name}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        // width: 100.0,
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
          // color: Colors.pink
          /* boxShadow: [
            BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 1.0,
                spreadRadius: 1.0,
                offset: Offset(0.1, 1.0))
          ],*/
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 30.0,
              color: Theme.of(context).accentColor,
            ),
            SizedBox(
              height: 8.0,
            ),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.12,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Popins",
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
