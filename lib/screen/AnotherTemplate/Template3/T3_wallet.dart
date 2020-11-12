import 'package:flutter/material.dart';

class T3_wallet extends StatefulWidget {
  T3_wallet({Key key}) : super(key: key);

  _T3_walletState createState() => _T3_walletState();
}

class _T3_walletState extends State<T3_wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       body: SingleChildScrollView(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[

             ///
             /// Credit card
             ///
             _cardHeader(),
             Padding(
               padding: const EdgeInsets.only(top:20.0,left: 15.0),
               child: Text("Preference from partner",style:TextStyle(color: Colors.black54,fontWeight: FontWeight.w400,fontFamily: "Sans",fontSize: 14.5,letterSpacing: 1.0)),
             ),
              SizedBox(height: 5.0,),
              card("assets/image/Template_3/twitchLogo.png","Twitch","12/11/2019"),
              card("assets/image/Template_3/solariaLogo.jpg","Solaria","02/06/2019"),
              card("assets/image/Template_3/slackLogo.png","Slack","12/10/2019"),
              SizedBox(height: 5.0,)
           ],
         ),
       ),
    );
  }


  Widget card(String img,String title,String date){
    return Padding(
      padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 19.0),
      child: Stack(
              children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: Stack(
                          children: <Widget>[
                Container(
                  height: 100.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              )
                            ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:135.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                                    Text(title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontFamily: "Sans",fontSize: 16.5),),
                  
                      Text(date,style: TextStyle(fontFamily: "Sans",fontWeight: FontWeight.w400,fontSize: 13.5,color: Colors.black26),),
                    ],
                    ),
                  ),
                ),
                 Align(
               alignment: Alignment.bottomRight,
                 child: Container(
                 height: 27.0,
                 width: 80.0,
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),bottomLeft: Radius.circular(20.0)),
                 color: Color(0xFF4A00E0)
                 ),
                 child: Center(
                   child: Text("   20%",style:TextStyle(color: Colors.white,fontWeight: FontWeight.w800,)),
                 ),
               ),
             )
              ],
            ),
          ),
                Padding(
                  padding: const EdgeInsets.only(left:14.0),
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(image: AssetImage(img),fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8.0,
                          color: Colors.black12.withOpacity(0.2),
                          spreadRadius: 5.0
                        )  
                      ],

                    ),
                  ),
                ),
            
        ],
      ),
    );
  }




    Widget _cardHeader(){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
         children: <Widget>[                 
          Container(
            height: 220.0,
            width: double.infinity,
            decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
            
            ),
            child: Padding(
              padding: const EdgeInsets.only(left:25.0,right: 25.0),
              child: Column(  
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 SizedBox(height: 30.0,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Text("CMB",style: TextStyle(fontWeight: FontWeight.w700,fontFamily: "Sans",fontSize: 20.0),),
                 Icon(Icons.spa)
               ],
             ),
                 SizedBox(height: 30.0,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Text("****   ****   ****",style: TextStyle(fontWeight: FontWeight.w700,fontFamily: "Sans",fontSize: 20.0),),
                  Text("3975",style: TextStyle(fontWeight: FontWeight.w700,fontFamily: "Sans",fontSize: 20.0),),
                
               ],
             ),
                 SizedBox(height: 20.0,),
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Text("Jipau Dev",style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Sans",fontSize: 18.0,),),
                  Column(
                    children: <Widget>[
            Text("Date",style: TextStyle(fontWeight: FontWeight.w300,fontFamily: "Sans",),),
                Text("07/21",style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Sans",fontSize: 16.0),)
                    ],
                  ),
               ],
             ),
               ],
              ),
            ),
          ),
           Align(
             alignment: Alignment.topRight,
                      child: Container(
                                  height: 170.0,
                                  width: 170.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white10.withOpacity(0.1),
                                    borderRadius: BorderRadius.only(bottomLeft:Radius.circular(200.0),topRight: Radius.circular(20.0))
                                  ),
                                ),
           ),
             Padding(
               padding: const EdgeInsets.only(top:50.0),
               child: Align(
               alignment: Alignment.bottomRight,
                        child: Container(
                                    height: 170.0,
                                    width: 170.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white10.withOpacity(0.1),
                                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(0.0),topLeft: Radius.circular(200.0))
                                    ),
                                  ),
           ),
             ),
        ],
              ),
      );
    }

}