import 'package:albarakahhalalfood/resources/routes/routes_name.dart';
import 'package:albarakahhalalfood/splashscreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../homepage.dart';

class AppRoutes{

  static appRoutes()=>[
    GetPage(name: RouteName.splashScreen, page: ()=> const SplashScreen(),transition: Transition.leftToRight, transitionDuration:const Duration(milliseconds: 500)),
    GetPage(name: RouteName.homeScreen, page: ()=> const HomePage(),transition: Transition.leftToRight, transitionDuration:const Duration(milliseconds: 500),),

  ];

}