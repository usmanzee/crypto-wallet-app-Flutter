import 'package:flutter/material.dart';

class withDraw extends StatefulWidget {
  final Widget child;

  withDraw({Key key, this.child}) : super(key: key);

  _withDrawState createState() => _withDrawState();
}

class _withDrawState extends State<withDraw> {
   @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
         children: <Widget>[
           Container(
             width: double.infinity,
             height: 100.0,
             decoration: BoxDecoration(
               color: Theme.of(context).canvasColor,
               borderRadius: BorderRadius.all(Radius.circular(10.0))
             ),
             child: Column(
               children: <Widget>[
           Padding(
             padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 19.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Text("Available (BCH)",style: TextStyle(color: Theme.of(context).hintColor.withOpacity(0.5),fontFamily: "Popins",fontSize: 15.5),),
                 Text("0",style: TextStyle(fontFamily: "Popins"),),
               ],
             ),
           ),
             Padding(
             padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 10.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Text("In Order (BCH)",style: TextStyle(color: Theme.of(context).hintColor.withOpacity(0.5),fontFamily: "Popins",fontSize: 15.5),),
                 Text("0",style: TextStyle(fontFamily: "Popins",color: Theme.of(context).hintColor.withOpacity(0.5),),),
               ],
             ),
           ),
               ],
             ),
           ),
           SizedBox(
             height: 20.0,
           ),
           Container(
             height:355.0,
             width: double.infinity, 
             decoration: BoxDecoration(
               color: Theme.of(context).canvasColor,
               borderRadius: BorderRadius.all(Radius.circular(10.0))
             ),
             child: Padding(
               padding: const EdgeInsets.only(left:18.0,right: 18.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   SizedBox(height: 27.0,),
           Text("BCH Withdrawal Address",style: TextStyle(color: Theme.of(context).hintColor.withOpacity(0.7),fontFamily: "Popins",),),
            Padding(
              padding: const EdgeInsets.only(right:5.0,bottom: 35.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Paste your deliver address",
                  hintStyle: TextStyle(color: Theme.of(context).hintColor,fontFamily: "Popins",fontSize: 15.0)
                ),
              ),
            ),

             Text("Quantity",style: TextStyle(color: Theme.of(context).hintColor.withOpacity(0.7),fontFamily: "Popins",),),
            TextField(
                    decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: TextStyle(color: Theme.of(context).hintColor,fontFamily: "Popins",fontSize: 15.0)
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text("24H Withdrawal Limit: 2 BTC",style: TextStyle(color: Theme.of(context).hintColor,fontFamily: "Popins",fontSize: 12.0),),
                  ),

                  SizedBox(height: 15.0,),
                    Text("Fee",style: TextStyle(color: Theme.of(context).hintColor.withOpacity(0.7),fontFamily: "Popins",),),
            TextField(
                    decoration: InputDecoration(
                      hintText: "0.001BCH",
                      hintStyle: TextStyle(color: Theme.of(context).hintColor,fontFamily: "Popins",fontSize: 15.0)
                    ),
                  ),
                 ],
               ),
             ),
           ),
           SizedBox(height: 20.0,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Text("Received Amount",style: TextStyle(color: Theme.of(context).hintColor),),
               Text("-0.001 BCH",style: TextStyle(color: Theme.of(context).hintColor.withOpacity(0.7)),)
             ],
           ),
           SizedBox(height: 5.0,),
          Container(
            height: 50.0,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text("Withdraw",style: TextStyle(fontFamily: "Popins",fontSize: 16.0,letterSpacing: 1.5,fontWeight: FontWeight.w700),),
            ),
            ),
           SizedBox(height: 20.0,)
         ],
      ),
    );
  }
}