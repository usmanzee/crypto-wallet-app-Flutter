import 'package:crypto_template/screen/AnotherTemplate/Template1/chat_item/T1_video_calling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class chatItem extends StatefulWidget {
  @override
  _chatItemState createState() => _chatItemState();
}

/// defaultUserName use in a Chat name
const String defaultUserName = "Alisa Hearth";

class _chatItemState extends State<chatItem> with TickerProviderStateMixin {
  /// set key for bottom sheet
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;

  /// Create Modal BottomSheet (SortBy)
  void _modalBottomSheetChat() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: new Container(
              height: 80.0,
              color: Color(0xFF141C35),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Image.asset(
                        "assets/image/icon/icon_image.png",
                        height: 45.0,
                      ),
                      Text(
                        "Photo",
                        style: TextStyle(fontFamily: "Popins", fontSize: 11.0),
                      )
                    ]),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => T1_video_calling()));
                      },
                      child: Column(children: <Widget>[
                        Image.asset(
                          "assets/image/icon/icon_video.png",
                          height: 45.0,
                        ),
                        Text(
                          "Video",
                          style:
                              TextStyle(fontFamily: "Popins", fontSize: 11.0),
                        )
                      ]),
                    ),
                    Column(children: <Widget>[
                      Image.asset(
                        "assets/image/icon/icon_microphone.png",
                        height: 45.0,
                      ),
                      Text(
                        "Voice",
                        style: TextStyle(fontFamily: "Popins", fontSize: 11.0),
                      )
                    ]),
                    Column(children: <Widget>[
                      Image.asset(
                        "assets/image/icon/icon_file.png",
                        height: 45.0,
                      ),
                      Text(
                        "File",
                        style: TextStyle(fontFamily: "Popins", fontSize: 11.0),
                      )
                    ]),
                    Column(children: <Widget>[
                      Image.asset(
                        "assets/image/icon/icon_monitor.png",
                        height: 45.0,
                      ),
                      Text(
                        "Screen",
                        style: TextStyle(fontFamily: "Popins", fontSize: 11.0),
                      )
                    ]),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      key: _key,
      backgroundColor: Color(0xFF141C35),

      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.4,
        title: Padding(
          padding: const EdgeInsets.only(right: 90.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 32.0,
                width: 32.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/avatars/avatar-1.jpg",
                        ),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19.0),
                child: Text(
                  "Alex",
                  style: TextStyle(
                      fontFamily: "Gotik", fontSize: 18.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white54),
        centerTitle: true,
        backgroundColor: Color(0xFF1A223E),
      ),

      /// body in chat like a list in a message
      body: Container(
        color: Color(0xFF141C35),
        child: new Column(children: <Widget>[
          new Flexible(
            child: _messages.length > 0
                ? Container(
                    child: new ListView.builder(
                      itemBuilder: (_, int index) => _messages[index],
                      itemCount: _messages.length,
                      reverse: true,
                      padding: new EdgeInsets.all(11.0),
                    ),
                  )
                : NoMessage(),
          ),

          /// Line
          Container(
            height: 0.4,
            width: double.infinity,
            color: Colors.white24,
          ),
          new Container(
            child: _buildComposer(),
            decoration: new BoxDecoration(
                color: Color(0xFF1A223E),
                boxShadow: [BoxShadow(blurRadius: 1.0, color: Colors.black12)]),
          ),
        ]),
      ),
    );
  }

  /// Component for typing text
  Widget _buildComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              InkWell(
                  onTap: _modalBottomSheetChat,
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                    size: 27.0,
                  )),
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
                        onSubmitted: _submitMsg,
                        decoration: new InputDecoration.collapsed(
                            hintText: "Enter some text to send a message",
                            hintStyle: TextStyle(
                                fontFamily: "Sans",
                                fontSize: 16.0,
                                color: Colors.white24)),
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
                          icon: new Icon(Icons.message),
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

  @override
  void dispose() {
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
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
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(1.0),
                              bottomLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              tileMode: TileMode.repeated,
                              colors: [Color(0xFF15EDED), Color(0xFF029CF5)])),
                      padding: const EdgeInsets.all(11.0),
                      child: new Text(
                        txt,
                        style: TextStyle(color: Colors.white),
                      ),
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

/// If list empty show no message image
class NoMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: ListView(
        children: <Widget>[
          /// image
          Padding(
            padding: const EdgeInsets.only(top: 150.0, bottom: 25.0),
            child: Center(
              child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    "assets/image/T1_noMessage.png",
                    height: 150.0,
                  )),
            ),
          ),
          Center(
              child: Text(
            "Not Have Message",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white24,
                fontSize: 17.0,
                fontFamily: "Popins"),
          ))
        ],
      ),
    ));
  }
}
