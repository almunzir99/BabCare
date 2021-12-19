import 'package:babcare/controllers/custom_drawer_controller.dart';
import 'package:babcare/views/pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class HomePage extends GetView<CustomDrawerController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomDrawerController>(
        builder: (_) => ZoomDrawer(
              controller: _.zoomDrawerController,
              menuScreen: Menu(),
              mainScreen: _.currentPage,
              borderRadius: 40.0,
              showShadow: true,
              angle: -12.0,
              isRtl: true,
              backgroundColor: Colors.grey.shade100,
              slideWidth: MediaQuery.of(context).size.width * 0.58,
            ));
  }
}
