import 'package:babcare/controllers/orders_controller.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/dashed_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "تابع طلب",
          ),
          foregroundColor: Colors.black,
          backgroundColor: backgroundColor,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .5,
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text.rich(TextSpan(children: [
                        const TextSpan(
                            text: " متابعة الطلب رقم ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.0)),
                        TextSpan(
                            text: "  ${controller.currentOrder!.id} # ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                                fontSize: 17.0))
                      ])),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .38,
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 35.0,
                                    width: 35.0,
                                    decoration: BoxDecoration(
                                        color:
                                            (controller.currentOrder!.status! >
                                                    0)
                                                ? accentColor
                                                : accentColor.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(17.5)),
                                    padding: const EdgeInsets.all(5.0),
                                    // ignore: prefer_const_constructors
                                    child: Icon(
                                      Icons.check,
                                      size: 18.0,
                                      color:
                                          (controller.currentOrder!.status! > 0)
                                              ? Colors.white
                                              : accentColor,
                                    ),
                                  ),
                                  DashSeparator(
                                    height:
                                        (MediaQuery.of(context).size.height *
                                                    .38) /
                                                3 -
                                            55,
                                    dashHeight: 3,
                                    color: accentColor.withOpacity(0.2),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 25.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("تم استلام الطلب"),
                                  Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Icon(
                                        LineIcons.clock,
                                        color: Colors.grey.shade500,
                                        size: 17.0,
                                      ),
                                      const SizedBox(
                                        width: 7.0,
                                      ),
                                      Text(
                                        "09:08 AM, 9 Jan 2021",
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 12.0),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 35.0,
                                    width: 35.0,
                                    decoration: BoxDecoration(
                                        color:
                                            (controller.currentOrder!.status! >
                                                    1)
                                                ? accentColor
                                                : accentColor.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(17.5)),
                                    padding: const EdgeInsets.all(5.0),
                                    // ignore: prefer_const_constructors
                                    child: Icon(
                                      Icons.outdoor_grill,
                                      size: 18.0,
                                      color:
                                          (controller.currentOrder!.status! > 1)
                                              ? Colors.white
                                              : accentColor,
                                    ),
                                  ),
                                  DashSeparator(
                                    height:
                                        (MediaQuery.of(context).size.height *
                                                    .38) /
                                                3 -
                                            55,
                                    dashHeight: 3,
                                    color: accentColor.withOpacity(0.2),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 25.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("تم تحضير الطلب"),
                                  Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Icon(
                                        LineIcons.clock,
                                        color: Colors.grey.shade500,
                                        size: 17.0,
                                      ),
                                      const SizedBox(
                                        width: 7.0,
                                      ),
                                      Text(
                                        "09:08 AM, 9 Jan 2021",
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 12.0),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 35.0,
                                    width: 35.0,
                                    decoration: BoxDecoration(
                                        color:
                                            (controller.currentOrder!.status! >
                                                    2)
                                                ? accentColor
                                                : accentColor.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(17.5)),
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.delivery_dining,
                                      size: 18.0,
                                      color:
                                          (controller.currentOrder!.status! > 2)
                                              ? Colors.white
                                              : accentColor,
                                    ),
                                  ),
                                  DashSeparator(
                                    height:
                                        (MediaQuery.of(context).size.height *
                                                    .38) /
                                                3 -
                                            55,
                                    dashHeight: 3,
                                    color: accentColor.withOpacity(0.2),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 25.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("قيد التوصيل"),
                                  Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Icon(
                                        LineIcons.clock,
                                        color: Colors.grey.shade500,
                                        size: 17.0,
                                      ),
                                      const SizedBox(
                                        width: 7.0,
                                      ),
                                      Text(
                                        "09:08 AM, 9 Jan 2021",
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 12.0),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 35.0,
                                    width: 35.0,
                                    decoration: BoxDecoration(
                                        color:
                                            (controller.currentOrder!.status! >
                                                    3)
                                                ? accentColor
                                                : accentColor.withOpacity(0.15),
                                        borderRadius:
                                            BorderRadius.circular(17.5)),
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      LineIcons.doubleCheck,
                                      size: 18.0,
                                      color:
                                          (controller.currentOrder!.status! > 3)
                                              ? Colors.white
                                              : accentColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 25.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("تم اكمال الطلب"),
                                  Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Icon(
                                        LineIcons.clock,
                                        color: Colors.grey.shade500,
                                        size: 17.0,
                                      ),
                                      const SizedBox(
                                        width: 7.0,
                                      ),
                                      Text(
                                        "09:08 AM, 9 Jan 2021",
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 12.0),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
