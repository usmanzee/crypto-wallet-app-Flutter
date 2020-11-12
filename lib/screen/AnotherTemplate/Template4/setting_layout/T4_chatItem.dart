import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// defaultUserName use in a Chat name
const String defaultUserName = "Alisa Hearth";

class T4_chatItem extends StatefulWidget {
  T4_chatItem({Key key}) : super(key: key);

  _T4_chatItemState createState() => _T4_chatItemState();
}

class _T4_chatItemState extends State<T4_chatItem> with TickerProviderStateMixin{
 
   final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /// body in chat like a list in a message
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
                        Text("Chat Operator",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700),)]),  )
                ],
              ),

          Expanded(
                      child: Container(
              color: Colors.white,
              child: new Column(children: <Widget>[
                new Flexible(
                  child: _messages.length>0
                      ?  Container(
                          child: new ListView.builder(
                            itemBuilder: (_, int index) => _messages[index],
                            itemCount: _messages.length,
                            reverse: true,
                            padding: new EdgeInsets.only(right:10.0,bottom: 10.0),
                          ),
                        ): NoMessage(),
                ),
                /// Line
                new Divider(height: 1.5),
                new Container(
                  child: _buildComposer(),
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 1.0, color: Colors.black12)]),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
/// Component for typing text
  Widget _buildComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Colors.yellow),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              Icon(Icons.add,color: Color(0xFFA665D1),size: 27.0,),
              new Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextField(
                        controller: _textController,
                        onChanged: (String txt) {
                          setState(() {
                            _isWriting = txt.length > 0;
                          });
                        },
                        style: TextStyle(color: Colors.black),
                        onSubmitted: _submitMsg,
                        decoration: new InputDecoration.collapsed(
                            hintText: "Enter some text to send a message",
                            hintStyle: TextStyle(
                                fontFamily: "Sans",
                                fontSize: 16.0,
                                color: Colors.black26)),
                      ),
                    ),
                  ),
                ),
              ),
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 3.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                      child: new Text("Submit"),
                      onPressed: _isWriting
                          ? () => _submitMsg(_textController.text)
                          : null)
                      : new IconButton(
                    icon: new Icon(Icons.message,color: Color(0xFFA665D1),),
                    onPressed: _isWriting
                        ? () => _submitMsg(_textController.text)
                        : null,
                  )),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border: new Border(top: new BorderSide(color: Colors.brown)))
              : null),
    );

    

  @override
  void dispose() {
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
  }

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    Msg msg = new Msg(
      txt: txt,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 800)),
    );
    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
  }


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

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController});

  final String txt;
  final AnimationController animationController;

  @override
  Widget build(BuildContext ctx) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.fastOutSlowIn),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Expanded(
              child: Padding(
                padding: const EdgeInsets.all(00.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(1.0),bottomLeft:Radius.circular(20.0),topRight:Radius.circular(20.0),topLeft:Radius.circular(20.0)),
                        color: Color(0xFFA665D1).withOpacity(0.6),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: new Text(txt,style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:100.0),
            child: Center(
              child: Opacity(
                opacity: 0.5,
                  child: Image.asset("assets/image/Template_4/noMessage.png",height: 220.0,)),
            ),
          ),
          Center(child: Text("Not Have Message", style: TextStyle( fontWeight: FontWeight.w300,color: Colors.black12,fontSize: 17.0,fontFamily: "Popins"),))
        ],
      ),
    ));
  }
}

