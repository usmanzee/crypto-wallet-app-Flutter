import 'package:flutter/material.dart';

class T4_banking extends StatefulWidget {
  T4_banking({Key key}) : super(key: key);

  _T4_bankingState createState() => _T4_bankingState();
}

class _T4_bankingState extends State<T4_banking> {
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
                      child: Text("Banking",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700),),
                    )
                ],
              ),

              ///
              /// Create card above appbar wave
              ///
               card("assets/image/Template_3/deals_layout/buildingMenu.png","Bank","Get best promo"),
            card("assets/image/Template_3/deals_layout/cardMenu.png","Credit Card","Get best promo"),
             card("assets/image/Template_3/deals_layout/financeMenu.png","Paid","Get best promo"),
             card("assets/image/Template_3/deals_layout/findMenu.png","Money","Get best promo"),
             card("assets/image/Template_3/deals_layout/giveMenu.png","Bonus","Get best promo"),
             card("assets/image/Template_3/deals_layout/growthMenu.png","Income","Get best promo"),
             card("assets/image/Template_3/deals_layout/locationMenu.png","Location","Get best promo"),
             card("assets/image/Template_3/deals_layout/moneyMenu.png","Exchange","Get best promo"),
             card("assets/image/Template_3/deals_layout/saveMenu.png","Exhange","Get best promo"),
             card("assets/image/Template_3/deals_layout/shareMenu.png","Plan","Get best promo"),
            
           ],
         ),
       ),
    );
  }

  ///
  /// Widget card category
  ///
  Widget card(String img, String title, String subTitle){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 120.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: Colors.black12.withOpacity(0.1),
              spreadRadius: 3.0
            ),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,style: TextStyle(fontFamily: "Popins",color: Colors.black87,fontWeight: FontWeight.w700,fontSize: 21.0,),),
               Text(subTitle,style: TextStyle(color: Colors.black54,fontFamily: "Sans",fontWeight: FontWeight.w600),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:20.0),
              child: Container(
                width: 100.0,
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
                  image: DecorationImage(image: AssetImage(img),fit: BoxFit.fill)
                ),
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