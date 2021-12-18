import 'package:babcare/theme/main_theme.dart';
import 'package:babcare/views/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
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
      home: const HomePage(),
    );
  }
}
