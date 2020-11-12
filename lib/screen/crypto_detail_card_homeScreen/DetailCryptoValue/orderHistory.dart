import 'package:crypto_template/component/CardDetail/orderHistory.dart';
import 'package:flutter/material.dart';

class orderHistory extends StatefulWidget {
  final Widget child;

  orderHistory({Key key, this.child}) : super(key: key);

  _orderHistoryState createState() => _orderHistoryState();
}

class _orderHistoryState extends State<orderHistory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 0.0, right: 0.0, top: 7.0, bottom: 7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Date",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins"),
                  ),
                ),
                Text(
                  "Type",
                  style: TextStyle(
                      color: Theme.of(context).hintColor, fontFamily: "Popins"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    "Price",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    "Amount",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins"),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 350.0,
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: listorderHistoryModel.length,
            itemBuilder: (BuildContext ctx, int i) {
              return _orderHistory(listorderHistoryModel[i]);
            },
          ),
        ),
      ],
    );
  }

  Widget _orderHistory(orderHistoryModel item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                item.date,
                style: TextStyle(
                    color:
                        Theme.of(context).textSelectionColor.withOpacity(0.4),
                    fontFamily: "Gotik",
                    fontSize: 15.0),
              ),
            ),
            Text(
              item.type,
              style: TextStyle(
                  fontFamily: "Gotik", fontSize: 15.0, color: Colors.red),
            ),
            Text(
              item.price,
              style: TextStyle(
                  color: Theme.of(context).textSelectionColor.withOpacity(0.4),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Gotik",
                  fontSize: 15.0),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Text(
                item.amount,
                style: TextStyle(
                    color:
                        Theme.of(context).textSelectionColor.withOpacity(0.4),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Gotik",
                    fontSize: 15.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
