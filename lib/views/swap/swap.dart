import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/swap_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:crypto_template/views/setting/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class Swap extends StatelessWidget {
  final SwapController swapController = Get.find();
  final WalletController walletController = Get.find();
  final HomeController homeController = Get.find();

  void _onKeyPressed(int key) {
    print(key);
    if (key == NumericalKeyboard.backspaceKey) {
      // if (_pin.length > 0) {
      //   setState(() {
      //     _pin = _pin.substring(0, _pin.length - 1);
      //   });
      // }
    } else {
      // setState(() {
      //   _pin += key.toString();
      // });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          'Swap',
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 0.8,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  if (Get.isDarkMode) {
                    Get.changeTheme(Themes.lightTheme);
                  } else {
                    Get.changeTheme(Themes.darkTheme);
                  }
                },
                child: Icon(
                  Icons.history,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(8, 40, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                'From',
                style: TextStyle(
                    fontFamily: "Popins",
                    color: Theme.of(context).hintColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/image/market/BCH.png',
                        height: 22.0,
                        fit: BoxFit.contain,
                        width: 22.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'BTC',
                          style: TextStyle(
                              fontFamily: "Popins",
                              color: Theme.of(context).textSelectionColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down),
                      Container(
                          height: 16,
                          child: VerticalDivider(
                              color: Theme.of(context).textSelectionColor)),
                      Flexible(
                        child: TextFormField(
                          autofocus: true,
                          showCursor: true,
                          readOnly: true,
                          cursorColor: Theme.of(context).textSelectionColor,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: "Price"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Container(
                            height: 16,
                            child: VerticalDivider(
                                color: Theme.of(context).textSelectionColor)),
                      ),
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          showModalBottomSheet(
                              context: context,
                              builder: (ctx) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Center(
                                    child: Text("Feature under development!"),
                                  ),
                                );
                              });
                        },
                        child: Text(
                          'Max',
                          style: TextStyle(
                              fontFamily: "Popins",
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(children: [
              Text(
                'Available: ',
                style: TextStyle(
                    fontFamily: "Popins",
                    color: Theme.of(context).hintColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w100),
              ),
              Text(
                '0.00 ',
                style: TextStyle(
                    fontFamily: "Popins",
                    color: Theme.of(context).hintColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'BTC',
                style: TextStyle(
                    fontFamily: "Popins",
                    color: Theme.of(context).hintColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text(
                'To',
                style: TextStyle(
                    fontFamily: "Popins",
                    color: Theme.of(context).hintColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/image/market/BCH.png',
                        height: 22.0,
                        fit: BoxFit.contain,
                        width: 22.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'BTC',
                          style: TextStyle(
                              fontFamily: "Popins",
                              color: Theme.of(context).textSelectionColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down),
                      Container(
                          height: 16,
                          child: VerticalDivider(
                              color: Theme.of(context).textSelectionColor)),
                      Flexible(
                        child: TextFormField(
                          cursorColor: Theme.of(context).textSelectionColor,
                          keyboardType: TextInputType.number,
                          showCursor: true,
                          readOnly: true,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: "Price"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  NumericalKeyboard(
                    onKeyPressed: _onKeyPressed,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      height: 40.0,
                      child: MaterialButton(
                        splashColor: Colors.black12,
                        highlightColor: Colors.black12,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {},
                        child: Center(
                            child: Text(
                          "Preview Rates",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Popins",
                              letterSpacing: 1.3,
                              fontSize: 16.0),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget line(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Container(
        width: double.infinity,
        height: 0.5,
        decoration: BoxDecoration(color: Theme.of(context).hintColor),
      ),
    );
  }
}

typedef KeyboardCallback(int key);

class NumericalKeyboard extends StatelessWidget {
  const NumericalKeyboard({Key key, this.onKeyPressed}) : super(key: key);

  static const backspaceKey = 42;
  static const clearKey = 69;

  final KeyboardCallback onKeyPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.grey[200],
      child: Table(
        defaultColumnWidth: IntrinsicColumnWidth(flex: 1.0),
        // border: TableBorder.all(),
        children: [
          TableRow(
            children: [
              _buildNumberKey(context, 1),
              _buildNumberKey(context, 2),
              _buildNumberKey(context, 3),
            ],
          ),
          TableRow(
            children: [
              _buildNumberKey(context, 4),
              _buildNumberKey(context, 5),
              _buildNumberKey(context, 6),
            ],
          ),
          TableRow(
            children: [
              _buildNumberKey(context, 7),
              _buildNumberKey(context, 8),
              _buildNumberKey(context, 9),
            ],
          ),
          TableRow(
            children: [
              _buildKey(
                  Text(
                    '.',
                    style: TextStyle(
                        fontFamily: "Popins",
                        color: Theme.of(context).textSelectionColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  backspaceKey),
              _buildNumberKey(context, 0),
              _buildKey(Icon(Icons.backspace), backspaceKey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberKey(BuildContext context, int n) {
    return _buildKey(
      Text('$n',
          style: TextStyle(
              fontFamily: "Popins",
              color: Theme.of(context).textSelectionColor,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      n,
    );
  }

  Widget _buildKey(Widget icon, int key) {
    return IconButton(
      icon: icon,
      padding: EdgeInsets.all(16.0),
      onPressed: () => onKeyPressed(key),
    );
  }
}

class NoKeyboardEditableText extends EditableText {
  NoKeyboardEditableText(
      {@required TextEditingController controller,
      @required TextStyle style,
      @required Color cursorColor,
      bool autofocus = false,
      Color selectionColor})
      : super(
            controller: controller,
            focusNode: NoKeyboardEditableTextFocusNode(),
            style: style,
            cursorColor: cursorColor,
            autofocus: autofocus,
            selectionColor: selectionColor,
            backgroundCursorColor: Colors.black);

  @override
  EditableTextState createState() {
    return NoKeyboardEditableTextState();
  }
}

class NoKeyboardEditableTextState extends EditableTextState {
  @override
  void requestKeyboard() {
    super.requestKeyboard();
    //hide keyboard
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class NoKeyboardEditableTextFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    // prevents keyboard from showing on first focus
    return false;
  }
}
