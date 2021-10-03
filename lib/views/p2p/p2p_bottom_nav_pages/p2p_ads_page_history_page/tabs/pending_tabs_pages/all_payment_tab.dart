import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page_history_page/tabs/pending_tabs_pages/payment_widget.dart';
import 'package:flutter/material.dart';

class AllPaymentTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) => PaymentWidget(),
    );
  }
}
