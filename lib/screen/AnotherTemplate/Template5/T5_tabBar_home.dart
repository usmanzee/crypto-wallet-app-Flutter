import 'package:flutter/material.dart';

import 'T5_home.dart';
import 'T5_noTransaction.dart';

class T5_tabBar_home extends StatefulWidget {
  T5_tabBar_home({Key key}) : super(key: key);

  _T5_tabBar_homeState createState() => _T5_tabBar_homeState();
}

class _T5_tabBar_homeState extends State<T5_tabBar_home> {
@override
  Widget build(BuildContext context) {

    ///
    /// Set length for tab bar
    ///
    return DefaultTabController(
      length: 12,
      child: Scaffold(
        backgroundColor: Color(0xFFF9F9F9),
          appBar: AppBar(
           backgroundColor: Colors.white,
         centerTitle: true,
         title: Text("Activity",style: TextStyle(fontFamily: "Lemon",fontWeight: FontWeight.w400,fontSize: 15.0,color: Colors.black87),),
         elevation: 0.2,
         actions: <Widget>[
           Padding(
             padding: const EdgeInsets.only(right:22.0),
             child: Image.asset("assets/image/Template_5/alarm.png",height: 18.0,width: 18.0,),
           ),
           Padding(
             padding: const EdgeInsets.only(right:12.0),
             child: Icon(Icons.calendar_today,color: Colors.black54,size: 19.0,),
           )
         ],

         ///
         ///  Include data for tab bar
         ///
           bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.black12.withOpacity(0.2),
                    indicatorColor: Colors.greenAccent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 2.5,
                    tabs: [
                      Tab(
                        child: Text('January'),
                      ),
                      Tab(
                        child: Text('February'),
                      ),
                      Tab(
                        child: Text('March'),
                      ),
                      Tab(
                        child: Text('April'),
                      ),
                      Tab(
                        child: Text('May'),
                      ),
                      Tab(
                        child: Text('June'),
                      ),
                      Tab(
                        child: Text('July'),
                      ),
                      Tab(
                        child: Text('August'),
                      ),
                      Tab(
                        child: Text('September'),
                      ),
                      Tab(
                        child: Text('October'),
                      ),
                      Tab(
                        child: Text('November'),
                      ),
                      Tab(
                        child: Text('December'),
                      ),
                    ]),
                preferredSize: Size.fromHeight(30.0)),
         
          ),
          body: TabBarView(
            children: <Widget>[
             T5_home(),
             T5_noTransaction(),
              T5_noTransaction(),
             T5_noTransaction(),
             T5_noTransaction(),
             T5_noTransaction(),
             T5_noTransaction(),
             T5_noTransaction(),
             T5_noTransaction(),
             T5_noTransaction(),
             T5_noTransaction(),
             T5_noTransaction(),
            ],
          )),
    );
  }
}