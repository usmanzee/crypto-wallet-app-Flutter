import 'package:flutter/material.dart';

class T4_transactions extends StatefulWidget {
  T4_transactions({Key key}) : super(key: key);

  _T4_transactionsState createState() => _T4_transactionsState();
}

class _T4_transactionsState extends State<T4_transactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFD),
       body: SingleChildScrollView(
         child: Column(
           children: <Widget>[
              Stack(
                children: <Widget>[

                ///
                /// Create wave appbar
                ///
                  ClipPath(
                       child: Container(
                         height: 160.0,
                         width: double.infinity,
                         decoration: BoxDecoration(
                           gradient: LinearGradient(
                             colors: [
                               Color(0xFFA665D1),
                               Color(0xFFFFBBCF)
                             ]
                           )
                         ),
                       ),
                         clipper: BottomWaveClipper(),
                    ),


                ///
                /// Get triangle widget
                ///
                    _triangle(20.0, 10.0,),
                    _triangle(110.0, 80.0,),
                    _triangle(60.0, 190.0,),
                    _triangle(40.0, 300.0,),
                    _triangle(130.0, 330.0,),
                    Padding(
                      padding: const EdgeInsets.only(top:70.0,left: 20.0),
                      child: Text("Transactions",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700),),
                    )
                ],
              ),

              ///
              /// Create box total transaction in below appbar
              ///
              Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15.0),
                child: Container(
                  height: 155.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 25.0,
                        color: Colors.black12.withOpacity(0.05),
                        spreadRadius: 5.0
                      )
                    ]
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0,),
                      Text("Total Transaction",style: TextStyle(color: Colors.black45,fontFamily: "Sans",fontSize: 13.0),),
                      SizedBox(height: 0.0,),
                      Text("\$32,457.46",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontFamily: "Popins",fontSize: 22.0,letterSpacing: 1.2),),
                      Padding(
                        padding: const EdgeInsets.only(top:15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 45.0,
                              width: 140.0,
                              color: Color(0xFFEEFCF6),
                              child: Center(
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 25.0,
                                      width: 25.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                        color: Colors.lightGreen
                                      ),
                                      child: Center(
                                        child: Icon(Icons.file_download,size: 15.0,),
                                      ),
                                    ),
                                    SizedBox(width: 7.0,),
                                    Text("+ \$3,210.00",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600,fontSize: 14.5,fontFamily: "Popins"),)]),
                              ),
                            ),
                            SizedBox(width: 20.0,),
                            Container(
                              height: 45.0,
                              width: 140.0,
                              color: Color(0xFFFCEEEE),
                              child: Center(
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 25.0,
                                      width: 25.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                        color: Colors.redAccent
                                      ),
                                      child: Center(
                                        child: Icon(Icons.file_upload,size: 15.0,),
                                      ),
                                    ),
                                    SizedBox(width: 7.0,),
                                    Text("- \$1,210.00",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w600,fontSize: 14.5,fontFamily: "Popins"),)]),
                              ),
                            ),
                          
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Today",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w700,fontSize: 16.0),),
                    Text("See All",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w400),)
                  ],
                ),
              ),

              ///
              /// List card today
              ///
             _cardToday(Colors.lightBlueAccent, Icons.monetization_on, "Salary", "Monthly Salary","+\$3000",Colors.green),
             _cardToday(Colors.yellow, Icons.phone, "Call Phone Bill", "Monthly Payment","-\$50",Colors.redAccent),
             _cardToday(Colors.deepPurpleAccent, Icons.home, "Home Payment", "Monthly Payment","-\$300",Colors.redAccent),
            SizedBox(height: 30.0,)
           ],
         ),
       ),
    );
  }

  ///
  /// Create card today widget
  ///
  Widget _cardToday(Color _backgroundIcon,IconData _icon,String _title,String _subTitle,String _value,Color _textColor){
    return Padding(
      padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 15.0),
      child: Container(
        height: 80.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 10.0,
              spreadRadius: 3.0
            ),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: Container(
                height: 45.0,
                width: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  color: _backgroundIcon
                ),
                child: Center(child: Icon(_icon),),
              ),
          ),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   Text(_title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
                   SizedBox(height: 5.0,),
                      Text(_subTitle,style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w400,fontSize: 13.0),)
                  
                ],
              ),
            ),
              ],
            ),
           
            Padding(
              padding: const EdgeInsets.only(right:20.0),
              child: Text(_value,style: TextStyle(color: _textColor,fontWeight: FontWeight.w800),),
            ),
               
          ],
        ),
      ),
    );
  }

  ///
  /// Create triangle 
  ///
  Widget _triangle(double top,left){
             return Padding(
                      padding:  EdgeInsets.only(top: top,left: left),
                      child: ClipPath(
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          color: Colors.white12.withOpacity(0.09),
                        ),
                          clipper: TriangleClipper(),
                      ),
                    );
  }

}


///
/// Create wave appbar
///
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}



///
/// Create triangle clipper
///
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}