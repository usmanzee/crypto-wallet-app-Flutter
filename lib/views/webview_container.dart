import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class WebViewContainer extends StatefulWidget {
  final appBarTitle;
  final url;

  WebViewContainer(this.appBarTitle, this.url);

  @override
  createState() => _WebViewContainerState(this.appBarTitle, this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _appBarTitle;
  var _url;
  final _key = UniqueKey();

  _WebViewContainerState(this._appBarTitle, this._url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
          centerTitle: true,
          title: Text(
            _appBarTitle != null ? _appBarTitle : 'B4U Wallet',
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
          elevation: 0.8,
        ),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url))
          ],
        ));
  }
}
