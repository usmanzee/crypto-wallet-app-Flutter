import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class WebViewContainer extends StatefulWidget {
  final String appBarTitle;
  final String url;

  WebViewContainer(this.appBarTitle, this.url);

  @override
  createState() => _WebViewContainerState(this.appBarTitle, this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  bool isLoading = true;
  String _appBarTitle;
  String _url;
  // final _key = UniqueKey();
  WebViewController _webViewController;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  _WebViewContainerState(this._appBarTitle, this._url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.theme.canvasColor,
        appBar: AppBar(
          backgroundColor: Get.theme.canvasColor,
          brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
          centerTitle: true,
          title: Text(
            _appBarTitle != null ? _appBarTitle : 'B4U Wallet',
            style: TextStyle(
                color: Get.theme.textSelectionTheme.selectionColor,
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5),
          ),
          iconTheme: IconThemeData(
              color: Get.theme.textSelectionTheme.selectionColor),
          elevation: 0.8,
        ),
        body: Stack(
          children: [
            WebView(
                // key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                  _webViewController
                      .evaluateJavascript("javascript:(function() { " +
                      "var head = document.getElementsByTagName('header')[0];" +
                      "head.parentNode.removeChild(head);" +
                      "var footer = document.getElementsByTagName('footer')[0];" +
                      "footer.parentNode.removeChild(footer);" +
                      "})()")
                      .then((value) => debugPrint('Page finished loading Javascript'))
                      .catchError((onError) => debugPrint('$onError'));
                },
                initialUrl: _url,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
                _controller.complete(webViewController);
              },
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        ));
  }
}
