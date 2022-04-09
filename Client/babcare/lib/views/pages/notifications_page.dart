import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/controllers/auth_controller.dart';
import 'package:babcare/controllers/dimmer_controller.dart';
import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/placeholders/dimmer.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());
    var dimmerController = Get.put(DimmerController());
    return Scaffold(
      appBar: AppBar(
          title: const Text("الاشعارات"),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: const Icon(LineIcons.doubleCheck),
              onPressed: () async {
                try {
                  dimmerController.showDimmer.value = true;
                  await authController.readNotifications();
                  authController.notifications.refresh();
                  dimmerController.showDimmer.value = false;
                } catch (e) {
                  dimmerController.showDimmer.value = false;

                  Alert(
                    context: context,
                    type: AlertType.error,
                    title: "خطأ",
                    desc: "فشلت العملية الرجاء اعاة المحاولة",
                    buttons: [
                      DialogButton(
                        color: primaryColor,
                        child: const Text(
                          "تمام",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                      )
                    ],
                  ).show();
                }
              },
            ),
          ]),
      body: Stack(
        children: [
          Obx(() {
            return ListView(
                physics: const BouncingScrollPhysics(),
                children: authController.notifications
                    .map((notification) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 15.0),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 05.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 1.0,
                                      style: BorderStyle.solid))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Icon
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.width * .15,
                                    width:
                                        MediaQuery.of(context).size.width * .15,
                                    decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width *
                                              .075,
                                        )),
                                    child: Center(
                                        child: Icon(
                                      LineIcons.bell,
                                      color: primaryColor,
                                      size: MediaQuery.of(context).size.width *
                                          0.12,
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .55,
                                        child: AutoSizeText(
                                          "${notification.title}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .55,
                                        child: AutoSizeText(
                                          "${notification.message}",
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Visibility(
                                visible: !notification.read!,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: accentColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: const Text(
                                    "جديد",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList());
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
    );
  }
}
