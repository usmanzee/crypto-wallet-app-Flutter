import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class T5_wallet extends StatefulWidget {
  T5_wallet({Key key}) : super(key: key);

  _T5_walletState createState() => _T5_walletState();
}

class _T5_walletState extends State<T5_wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
      centerTitle: true,
         title: Text("Credit Cards",style: TextStyle(fontFamily: "Lemon",fontWeight: FontWeight.w400,fontSize: 15.0,color: Colors.black87),),
        elevation: 0.2,
      ),
       body: SingleChildScrollView(
         child: Column(
           children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:0.0,right: 10.0,top: 20.0),
                child: Image.asset("assets/image/Template_5/creditCard.png",width: double.infinity,fit: BoxFit.cover,),
              ),
              SizedBox(height: 10.0,),
              _bankAccount(),
              SizedBox(height: 20.0,),
              _inviteFriends(),
              SizedBox(height: 30.0,),
           ],
         ),
       ),
    );
  }


  ///
  /// Box for bank account 
  ///
  Widget _bankAccount(){
    return Padding(
       padding: const EdgeInsets.only(left:12.0,right: 12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
             borderRadius: BorderRadius.all(Radius.circular(10.0)),
             color: Colors.white,
              boxShadow: [
              BoxShadow(
                   color: Colors.black.withOpacity(0.1),
                  blurRadius: 15.0,
                  spreadRadius: 0.0
              )
            ]
               
        ),
        child: Column(
          children: <Widget>[
            Padding(
                  padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Your bank accounts ",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w800,fontSize: 16.5),),
                      Container(
                        width: 70.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 2.0,
                              spreadRadius: 1.0
                            )
                          ]
                        ),
                        child: Center(child: Text("See All",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w400,fontSize: 13.0),)))
                    ],
                  ),
                ),
                SizedBox(height: 15.0,),
                Row(
                  children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: Container(
                    height: 45.0,
                    width: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      color: Colors.lightBlueAccent
                    ),
                    child: Center(child: Icon(Icons.account_balance),),
                  ),
            ),
                Padding(
                  padding: const EdgeInsets.only(left:10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       Text("Austin Hammond",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w700),),
                       SizedBox(height: 5.0,),
                          Text("IBAN: US34-INGB 0001 9999 0012 1569",style: TextStyle(color: Colors.black26,fontWeight: FontWeight.w400,fontSize: 12.0),),
                       SizedBox(height: 5.0,),
                          Text("BIC / SWIFT - INGBUSBU",style: TextStyle(color: Colors.black26,fontWeight: FontWeight.w400,fontSize: 12.0),),
                      
                    ],
                  ),
                ),
                  ],
                ), 
          SizedBox(height: 25.0,),
          ],
        ),
      ),
    );
  }



///
/// Box gradient blue invite friend
///
  Widget _inviteFriends(){
    return Padding(
       padding: const EdgeInsets.only(left:12.0,right: 12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
             borderRadius: BorderRadius.all(Radius.circular(10.0)),
             gradient: LinearGradient(
               colors: [
                 Color(0xFF20BFF6),
                 Color(0xFF1F9BE9)
               ]
             ),
              boxShadow: [
            BoxShadow(
              offset: Offset(6,7),
              color: Color(0xFF20BFF6).withOpacity(0.15),
              blurRadius: 5.0,
              spreadRadius: 1.0
            )
          ]
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
                Row(
                  children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      color: Colors.white
                    ),
                    child: Center(child: Icon(Icons.account_balance,color: Color(0xFF20BFF6),),),
                  ),
            ),
                Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       Text("Invite Friends. Get reward",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16.0),),
                       SizedBox(height: 10.0,),
                          Text("Send your friends invitations and win",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12.0),),
                       SizedBox(height: 5.0,),
                          Text("a free Premium account",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12.0),),
                      
                    ],
                  ),
                ),
                  ],
                ), 
          SizedBox(height: 25.0,),
          ],
        ),
      ),
    );
  }



}