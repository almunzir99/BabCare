import 'package:babcare/controllers/custom_drawer_controller.dart';
import 'package:babcare/routing.dart';
import 'package:babcare/theme/main_theme.dart';
import 'package:babcare/views/pages/home.dart';
import 'package:babcare/views/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  Get.put<CustomDrawerController>(CustomDrawerController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'تطبيق بابكير لطلب الطعام',
      theme: mainTheme,
      getPages: routes,
      initialRoute: "/login",
      textDirection: TextDirection.rtl,
      home: LoginPage(),
    );
  }
}
