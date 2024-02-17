import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebPage extends StatefulWidget {
  const MyWebPage({super.key, required this.controller});

  final WebViewController controller;

  @override
  State<MyWebPage> createState() => _MyWebPageState();
}

class _MyWebPageState extends State<MyWebPage> {
  var loadingPercenteg = 0;

  @override
  void initState() {
    super.initState();
    widget.controller
      ..setNavigationDelegate(
        NavigationDelegate(onPageStarted: (url) {
          setState(() {
            loadingPercenteg = 0;
          });
        }, onProgress: (progress) {
          setState(() {
            loadingPercenteg = progress;
          });
        }, onPageFinished: (url) {
          setState(() {
            loadingPercenteg = 100;
          });
        }),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("snackBar", onMessageReceived: (message) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message.message)));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: widget.controller),
        if (loadingPercenteg < 100)
          LinearProgressIndicator(
            value: loadingPercenteg / 100.0,
          )
      ],
    );
  }
}
