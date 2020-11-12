import 'package:crypto_template/screen/AnotherTemplate/Template4/model_data/notification_model.dart';
import 'package:flutter/material.dart';

class T4_notification extends StatefulWidget {
  T4_notification({Key key}) : super(key: key);

  _T4_notificationState createState() => _T4_notificationState();
}

class _T4_notificationState extends State<T4_notification> {
  final List<Post> items = new List();
  @override

  ///
  /// Add data for notification data dummy
  ///
  void initState() {
    super.initState();
    setState(() {
      items.add(
        Post(
            image: "assets/image/Template_3/deals_layout/buildingMenu.png",
            id: 1,
            title: "Bank Account",
            desc: "Thanks for downloaded ui kit from jipau"),
      );
      items.add(
        Post(
            image: "assets/image/Template_3/deals_layout/buildingMenu.png",
            id: 2,
            title: "Bank Account",
            desc: "Your transaction done in 21/04/2019"),
      );
      items.add(
        Post(
            image: "assets/image/Template_3/deals_layout/buildingMenu.png",
            id: 3,
            title: "Bank Account",
            desc: "Pending payment"),
      );
      items.add(
        Post(
            image: "assets/image/Template_3/deals_layout/buildingMenu.png",
            id: 4,
            title: "Bank Account",
            desc: "Get spesial discount for use wallet "),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                          colors: [Color(0xFFA665D1), Color(0xFFFFBBCF)])),
                ),
                clipper: BottomWaveClipper(),
              ),

              ///
              /// Get triangle widget
              ///
              _triangle(
                20.0,
                10.0,
              ),
              _triangle(
                110.0,
                80.0,
              ),
              _triangle(
                60.0,
                190.0,
              ),
              _triangle(
                40.0,
                300.0,
              ),
              _triangle(
                130.0,
                330.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0, left: 20.0),
                child: Row(children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 19.0,
                      )),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Notification",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  )
                ]),
              )
            ],
          ),
          Expanded(
            child: items.length > 0
                ? ListView.builder(
                    itemCount: items.length,
                    padding: const EdgeInsets.all(5.0),
                    itemBuilder: (context, position) {
                      return Dismissible(
                          key: Key(items[position].id.toString()),
                          onDismissed: (direction) {
                            setState(() {
                              items.removeAt(position);
                            });
                          },
                          background: Container(
                            color: Color(0xFFFFBBCF),
                          ),
                          child: Container(
                            height: 88.0,
                            child: Column(
                              children: <Widget>[
                                Divider(
                                  height: 5.0,
                                  color: Colors.black12,
                                ),
                                ListTile(
                                  title: Text(
                                    '${items[position].title}',
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Container(
                                      width: 440.0,
                                      child: Text(
                                        '${items[position].desc}',
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black38),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  leading: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 40.0,
                                        width: 40.0,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(60.0)),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    '${items[position].image}'),
                                                fit: BoxFit.cover)),
                                      )
                                    ],
                                  ),
                                  onTap: () =>
                                      _onTapItem(context, items[position]),
                                ),
                                Divider(
                                  height: 5.0,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                          ));
                    })
                : noItemNotifications(),
          )
        ],
      ),
    );
  }

  void _onTapItem(BuildContext context, Post post) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(post.id.toString() + ' - ' + post.title)));
  }

  Widget noItemNotifications() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
            Image.asset(
              "assets/image/Template_4/notifications.png",
              height: 200.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            Text(
              "Not Have Notification",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.5,
                  color: Colors.black54,
                  fontFamily: "Gotik"),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Create triangle
  ///
  Widget _triangle(double top, left) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: left),
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
