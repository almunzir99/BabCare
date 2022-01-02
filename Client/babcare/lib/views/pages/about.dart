import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/controllers/custom_drawer_controller.dart';
import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

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
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Center(
                //   child: SvgPicture.asset(
                //     "assets/images/logo.svg",
                //     height: 60,
                //   ),
                // ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "الاصدار 0.1",
                  style: TextStyle(color: Colors.grey, fontSize: 22.0),
                ),
                const SizedBox(
                  height: 35.0,
                ),
                Text(
                  "عن بابكير",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const AutoSizeText(
                    "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها."),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "تواصل مع باكير",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 160.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        LineIcons.phone,
                        color: primaryColor,
                        size: 20.0,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const AutoSizeText(
                        "012 3456 789",
                        style: TextStyle(fontSize: 18.0),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  width: 160,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        LineIcons.envelope,
                        color: primaryColor,
                        size: 20.0,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const AutoSizeText(
                        "media@tahfiz.com",
                        style: TextStyle(fontSize: 18.0),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
