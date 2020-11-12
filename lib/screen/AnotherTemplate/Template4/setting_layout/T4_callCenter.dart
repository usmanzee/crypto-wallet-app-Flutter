import 'package:crypto_template/screen/AnotherTemplate/Template4/setting_layout/T4_chatItem.dart';
import 'package:flutter/material.dart';


class T4_callCenter extends StatefulWidget {
  T4_callCenter({Key key}) : super(key: key);

  _T4_callCenterState createState() => _T4_callCenterState();
}

class _T4_callCenterState extends State<T4_callCenter> {

  static var _txtCustomHead = TextStyle(
  color: Colors.black54,
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Gotik",
 );

 static var _txtCustomSub = TextStyle(
  color: Colors.black26,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  fontFamily: "Gotik",
 );


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
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
                      child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 19.0,)),
                        SizedBox(width: 10.0,),
                        Text("Call Center",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700),)]), )
                ],
              ),
              SizedBox(height: 80.0,),
               Image.asset(
              "assets/image/Template_4/contact_us.png",
              height: 175.0,
             ),
             Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Text(
               "We're Happy to Help You!",
               style: _txtCustomHead,
              ),
             ),
             Padding(
              padding:
              const EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
              child: Text(
               "If you have complain about \nthe product chat me ",
               style: _txtCustomSub,
               textAlign: TextAlign.center,
              ),
             ),
             Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: InkWell(
               onTap: () {
                 Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___)=> T4_chatItem()));
               },
               child: Center(
                child: Container(
                 height: 50.0,
                 width: 280.0,
                 decoration: BoxDecoration(
                     color: Color(0xFFA665D1),
                     borderRadius:
                     BorderRadius.all(Radius.circular(25.0))),
                 child: Center(
                     child: Text(
                      "Chat Me",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0),
                     )),
                ),
               ),
              ),
             )
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