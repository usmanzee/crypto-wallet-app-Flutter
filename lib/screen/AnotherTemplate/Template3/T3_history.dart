import 'package:flutter/material.dart';

class T3_history extends StatefulWidget {
  T3_history({Key key}) : super(key: key);

  _T3_historyState createState() => _T3_historyState();
}

class _T3_historyState extends State<T3_history> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
       body: SingleChildScrollView(
                child: Column(
                                  children: <Widget>[
          _card("09 April 2019","ONLINE SHOP","Reward","+11.600 Point"),
          _card("08 April 2019","MEDICAL CHECK UP","Payment","-5.200 Point"),
          _card("07 April 2019","TRANSPORT","Payment","-1.000 Point"),
          _card("06 April 2019","ENTERTAINMENT","Payment","+3.600 Point"),
          _card("05 April 2019","HANGOUT","Payment","+5.100 Point"),
          _card("04 April 2019","WORKOUT","Payment","+2.200 Point"),
          _card("03 April 2019","ONLINE SHOP","Reward","+5.600 Point"),
         ],
                ),
       ),
    );
  }

  ///
  /// Card under of tab bar
  ///
  Widget _card(String time,String title,String subTitle,String value){
    return Column(
      children: <Widget>[
        Container(
          height: 35.0,
          width: double.infinity,
          color: Color(0xFFECEFF1),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Text(time,style: TextStyle(color: Color(0xFF546E7A),fontWeight: FontWeight.w600)),
            ),
        ),),
        Padding(
          padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,style: TextStyle(color: Colors.black,fontFamily: "Sans",fontWeight: FontWeight.w600,fontSize: 16.0),),
                  SizedBox(height: 5.0,),
                  Text("Rewards",style: TextStyle(color: Colors.black45),)
                ],
              ),
              Text(value,style: TextStyle(color: Color(0xFF4d2a86),fontFamily: "Sans"),)
            ],
          ),
        ),
        SizedBox(height: 10.0,)
      ],
    );
  }
}