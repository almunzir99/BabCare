import 'package:babcare/views/pages/about.dart';
import 'package:babcare/views/pages/orders.dart';
import 'package:babcare/views/pages/policies.dart';
import 'package:babcare/views/pages/tabs_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icons.dart';

class MenuItem {
  String title;
  IconData icon;
  String? route;
  Widget? page;
  MenuItem(this.title, this.icon, {this.page, this.route});
}

final List<MenuItem> menuItems = [
  MenuItem("الرئيسية", LineIcons.home, page: const TabsView()),
  MenuItem("طلباتي", LineIcons.clipboardList, page: const OrdersPage()),
  MenuItem("سياسات الخصوصية", LineIcons.userShield, page: const PoliciesPage()),
  MenuItem("عنا", LineIcons.infoCircle, page: const AboutPage()),
  MenuItem("تسجيل الخروج", LineIcons.alternateSignOut),
];
