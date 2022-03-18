import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/controllers/custom_drawer_controller.dart';
import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class OrdersPage extends StatelessWidget {
  final bool hideAppBar;
  const OrdersPage({Key? key, this.hideAppBar = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var drawerController = Get.put(CustomDrawerController());
    return Scaffold(
        appBar: hideAppBar
            ? null
            : AppBar(
                leading: IconButton(
                  onPressed: () {
                    drawerController.toggleDrawer();
                  },
                  icon: const Icon(
                    LineIcons.bars,
                    color: Colors.black,
                  ),
                ),
                title: const Center(
                  child: Text(
                    "طلباتي",
                  ),
                ),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to("/cart");
                      },
                      icon: const Icon(LineIcons.shoppingBasket))
                ],
              ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Text(
                "عندك 3 طلبات",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: hideAppBar == true
                  ? MediaQuery.of(context).size.height * .69
                  : MediaQuery.of(context).size.height * .75,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: ListView(
                children: ["17", "20", "300"]
                    .map((e) => GestureDetector(
                          onTap: () {
                            Get.toNamed("/order_detail");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 65.0,
                                  width: 65.0,
                                  padding: const EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35.0),
                                    color: accentColor.withOpacity(0.3),
                                  ),
                                  child: Center(
                                    child: AutoSizeText(
                                      // ignore: unnecessary_string_interpolations
                                      "$e #",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                        color: accentColor,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(TextSpan(children: [
                                      const TextSpan(
                                          text: "رقم الطلب",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: " #$e ",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: accentColor)),
                                    ])),
                                    const SizedBox(
                                      height: 05.0,
                                    ),
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Icon(LineIcons.calendar),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        // ignore: prefer_const_constructors
                                        Text("23 ديسمبر 2021"),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    SizedBox(
                                      height: 40.0,
                                      width: MediaQuery.of(context).size.width *
                                          0.62,
                                      child: Stack(
                                        children: [
                                          1,
                                          2,
                                          3,
                                          4,
                                        ]
                                            .map((e) => Positioned(
                                                  right: (e - 1) * 25.0,
                                                  child: Container(
                                                    height: 40.0,
                                                    width: 40.0,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 3.0)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Image(
                                                        image: AssetImage(
                                                            "assets/temp/food/image-${e + 3}.png"),
                                                        height: 40.0,
                                                        width: 40.0,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      const TextSpan(
                                          text: "حالة الطلب :",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: " قيد التوصيل ",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: accentColor)),
                                    ])),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ));
  }
}
