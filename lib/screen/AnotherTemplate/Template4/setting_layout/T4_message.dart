import 'package:flutter/material.dart';

class T4_message extends StatefulWidget {
  T4_message({Key key}) : super(key: key);

  _T4_messageState createState() => _T4_messageState();
}

class _T4_messageState extends State<T4_message> {
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
                        Text("Message",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700),)]), )
                ],
              ),
              Container(
                color: Colors.white,
                width: 500.0,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 100.0)),
                  Image.asset(
              "assets/image/Template_4/notifications.png",
              height: 200.0,
            ),
                  Padding(padding: EdgeInsets.only(bottom: 20.0)),
                  Text(
                  "Not Message Yet",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 19.5,
                      color: Colors.black54,
                      fontFamily: "Gotik"),
                  ),
                ],
                ),
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