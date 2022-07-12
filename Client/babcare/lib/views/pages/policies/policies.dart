import 'package:babcare/controllers/custom_drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class PoliciesPage extends StatelessWidget {
  const PoliciesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var drawerController = Get.put(CustomDrawerController());
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              drawerController.toggleDrawer();
            },
            icon: const Icon(
              LineIcons.bars,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container());
  }
}
