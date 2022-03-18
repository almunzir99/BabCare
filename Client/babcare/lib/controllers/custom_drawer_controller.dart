import 'package:babcare/constants/menu_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class CustomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Widget? _currentPage = menuItems[0].page;
  get currentPage => _currentPage;
  void navigate(int index) {
    if (index < menuItems.length - 1) {
      _currentPage = menuItems[index].page;
      toggleDrawer();
    }
    if (index == menuItems.length - 1) Get.offAllNamed("/login");
  }

  void toggleDrawer() {
    zoomDrawerController.toggle!.call();
    update();
  }
}
