import 'package:babcare_delivery/views/pages/login/login.dart';
import 'package:babcare_delivery/views/pages/notifications/notifications_page.dart';
import 'package:babcare_delivery/views/pages/tabs_view/tabs_view.dart';
import 'package:get/get.dart';

final List<GetPage> routes = [
  GetPage(name: "/login", page: () => LoginPage()),
  GetPage(name: "/tabs", page: () => const TabsView()),
  GetPage(name: "/notifications", page: () => const NotificationsPage())
];
