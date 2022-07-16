import 'package:babcare_delivery/controllers/auth_controller.dart';
import 'package:babcare_delivery/controllers/dimmer_controller.dart';
import 'package:babcare_delivery/controllers/tabs_view_controller.dart';
import 'package:babcare_delivery/theme/style.dart';
import 'package:babcare_delivery/views/components/dimmer.dart';
import 'package:babcare_delivery/views/pages/about/about_page.dart';
import 'package:babcare_delivery/views/pages/account/account_page.dart';
import 'package:babcare_delivery/views/pages/home/home_page.dart';
import 'package:babcare_delivery/views/pages/orders/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class TabsView extends StatelessWidget {
  const TabsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dimmerController = Get.put(DimmerController());
    var authController = Get.put(AuthController());
    var controller = Get.put(TabsViewController());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تطبيق بابكير للتوصيل",
          style: TextStyle(
              fontSize: size.width * .05, fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.black,
        centerTitle: true,
        actions: [
          Container(
              height: size.width * .069,
              width: size.width * .083,
              margin:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
              child: Stack(
                children: [
                  //icon
                  IconButton(
                      onPressed: () {
                        Get.toNamed("/notifications");
                      },
                      icon: Icon(
                        LineIcons.bell,
                        color: Colors.black,
                        size: size.width * .077,
                      )),
                  //badge
                  Positioned(
                    top: 10.0,
                    left: 10.0,
                    child: Obx(() {
                      return Visibility(
                        visible: authController.notifications
                            .where((p0) => !p0.read!)
                            .isNotEmpty,
                        child: Container(
                          height: 15.0,
                          width: 15.0,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              "${authController.notifications.where((p0) => !p0.read!).length}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Obx(() {
            return IndexedStack(
              index: controller.selectedIndex,
              children: const [
                HomePage(),
                OrdersPage(),
                AccountPage(),
                AboutPage()
              ],
            );
          }),
          Obx(() {
            return Center(
              child: Dimmer(
                show: dimmerController.showDimmer.value,
              ),
            );
          })
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: primaryColor,
              hoverColor: primaryColor,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: primaryColor,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'الرئيسية',
                ),
                GButton(
                  icon: LineIcons.clipboardList,
                  text: 'الطلبات',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'حسابي',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'عن التطبيق',
                ),
              ],
              selectedIndex: controller.selectedIndex,
              onTabChange: (index) {
                controller.selectedIndex = index;
              },
            ),
          ),
        ),
      ),
    );
  }
}
