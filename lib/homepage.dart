import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late StreamSubscription subscription;

  var isDeviceConnected = false;
  bool isAlertSet = false;


  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    loadWebPage();
    getConnectivity();
  }
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }


  loadWebPage() {
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://mydailyshop.jp/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBarText".tr),
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);

                    if (await controller.canGoBack()) {
                      await controller.goBack();
                    } else {
                      messenger.showSnackBar(
                        const SnackBar(content: Text("no back found!")),
                      );
                      return;
                    }
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              IconButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);

                    if (await controller.canGoForward()) {
                      await controller.goForward();
                    } else {
                      messenger.showSnackBar(
                        const SnackBar(
                            content: Text("no forward found!")),
                      );
                      return;
                    }
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
              IconButton(
                  onPressed: () {
                    controller.reload();
                  },
                  icon: Icon(Icons.refresh)),
            ],
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () => onBackPressAlert(context),
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }

  Future<bool> onBackPressAlert(BuildContext context) async {
    bool? exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("splashScreen_Text".tr),
            content: Text('onbackPressAlertText'.tr),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('onbackPressAlertNoButton'.tr)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('onbackPressAlertYesButton'.tr)),
            ],
          );
        });
    return exitApp ?? false;
  }

  void getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;

          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },

      );

  showDialogBox() =>
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
              title: Text('NoInternetAlertTitle'.tr),
              content: Text('NoInternetAlertDescription'.tr),
              actions: [
                TextButton(onPressed: () async {
                  Navigator.pop(context, 'NoInternetAlertCancleButton'.tr);
                  setState(() => isAlertSet = false);
                  isDeviceConnected =
                  await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected) {
                    showDialogBox();
                    setState(() => isAlertSet = true);
                  }
                }, child: Text('NoInternetAlertOkButton'.tr))
              ],

            ),
      );
}
