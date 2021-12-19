import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/constants/dimensions.dart';
import 'package:babcare/constants/menu_items.dart';
import 'package:babcare/controllers/custom_drawer_controller.dart';
import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);
  var controller = Get.put(CustomDrawerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        padding: const EdgeInsets.only(top: 80.0, right: 20.0),
        child: ListView(
          children: [
            // user profile photo and info
            Row(
              children: [
                // image-container
                SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 75.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white.withOpacity(0.3)),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: 75.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: const Image(
                              image: AssetImage("assets/temp/user.jpg"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // user-info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      //name
                      AutoSizeText(
                        "المنذر الحسن",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                      SizedBox(height: 07.0),
                      // address
                      AutoSizeText(
                        "الخرطوم, شرق النيل  , الحاج يوسف",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            // menu
            Column(
              children: menuItems.map((item) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      var index = menuItems.indexOf(item);
                      controller.navigate(index);
                    },
                    child: Container(
                      width: screenWidth,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          AutoSizeText(
                            item.title,
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
