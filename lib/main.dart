import 'package:albarakahhalalfood/resources/localization/Languages.dart';
import 'package:albarakahhalalfood/resources/routes/routes.dart';
import 'package:albarakahhalalfood/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: const Locale("en","US"),
      fallbackLocale: const Locale("en","US"),
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: false,
      ),
      getPages: AppRoutes.appRoutes(),
    );
  }
}

