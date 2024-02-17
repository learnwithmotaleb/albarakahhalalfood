import 'dart:async';

import 'package:albarakahhalalfood/resources/assets_image/Assets_Image.dart';
import 'package:albarakahhalalfood/resources/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    isLogin();
    super.initState();
  }

  void isLogin(){

  Timer(Duration(seconds: 5), () {
    Timer( Duration(seconds: 2),(){
      Navigator.pop(context);
      Get.toNamed(RouteName.homeScreen,);
    });
  });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImageAssets.splashLogo,width: 200,height: 200,),
          SizedBox(height: 20,),
          Center(
            child: Text("splashScreen_Text".tr,style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),),
          ),
        ],
      ),

    );
  }
}
