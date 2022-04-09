import 'package:babcare/controllers/custom_drawer_controller.dart';
import 'package:babcare/routing.dart';
import 'package:babcare/services/notifications_services.dart';
import 'package:babcare/services/signalr_service.dart';
import 'package:babcare/theme/main_theme.dart';
import 'package:babcare/views/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'controllers/cart_controller.dart';

Future<void> main() async {
  Get.put(CartController());
  Get.put<CustomDrawerController>(CustomDrawerController());
  final _authController = Get.put(AuthController());

  runApp(const MyApp());
  var signalrService = SignalRService.instance;
  var notificationService = NotificationsService.instance;
  await notificationService.init();
  await signalrService.initializeConnection();
  signalrService.onNotificationRecieved((notification) {
    _authController.notifications.insert(0, notification);
    _authController.notifications.refresh();
    notificationService.pushNotification(notification);
  });
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
