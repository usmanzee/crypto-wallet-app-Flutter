import 'package:flutter/material.dart';

class LimitOrderForm extends StatefulWidget {
  @override
  _LimitOrderFormState createState() => _LimitOrderFormState();
}

class _LimitOrderFormState extends State<LimitOrderForm> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 50,
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Row(
                children: [
                  Icon(Icons.add),
                  Flexible(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.name,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Price"),
                    ),
                  ),
                  Icon(Icons.remove),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 50,
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Row(
                children: [
                  Icon(Icons.add),
                  Flexible(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.name,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Price"),
                    ),
                  ),
                  Icon(Icons.remove),
                ],
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 50,
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Row(
                children: [
                  Icon(Icons.add),
                  Flexible(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.name,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Amount"),
                    ),
                  ),
                  Icon(Icons.remove),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 50,
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Row(
                children: [
                  Icon(Icons.add),
                  Flexible(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.name,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Amount"),
                    ),
                  ),
                  Icon(Icons.remove),
                ],
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 50,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    print('25%');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    color: Theme.of(context).canvasColor,
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        '25%',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    print('50%');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    color: Theme.of(context).canvasColor,
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        '50%',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    print('75%');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    color: Theme.of(context).canvasColor,
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        '75%',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    print('100%');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    color: Theme.of(context).canvasColor,
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        '100%',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 50,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    print('25%');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    color: Theme.of(context).canvasColor,
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        '25%',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    print('50%');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    color: Theme.of(context).canvasColor,
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        '50%',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    print('75%');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    color: Theme.of(context).canvasColor,
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        '75%',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    print('100%');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    color: Theme.of(context).canvasColor,
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        '100%',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 50,
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.name,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Total(BTC)"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 50,
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.name,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Total(BTC)"),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 50,
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width / 2,
                      child: MaterialButton(
                        splashColor: Colors.black12,
                        highlightColor: Colors.black12,
                        color: Color(0xFF2ebd85),
                        onPressed: () {},
                        child: Center(
                            child: Text(
                          "Buy",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Popins",
                              letterSpacing: 1.3,
                              fontSize: 16.0),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 50,
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width / 2,
                      child: MaterialButton(
                        splashColor: Colors.black12,
                        highlightColor: Colors.black12,
                        color: Colors.redAccent.withOpacity(0.8),
                        onPressed: () {},
                        child: Center(
                            child: Text(
                          "Sell",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Popins",
                              letterSpacing: 1.3,
                              fontSize: 16.0),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: 8,
      ),
    ]);
  }
}
