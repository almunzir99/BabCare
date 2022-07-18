import 'package:babcare_delivery/controllers/auth_controller.dart';
import 'package:babcare_delivery/controllers/orders_controller.dart';
import 'package:babcare_delivery/theme/style.dart';
import 'package:babcare_delivery/views/components/error_placeholder.dart';
import 'package:babcare_delivery/views/pages/order_detail/order_detail_info.dart';
import 'package:babcare_delivery/views/pages/order_detail/order_detail_map.dart';
import 'package:babcare_delivery/views/pages/order_detail/order_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    final authController = Get.put(AuthController());

    var orderId = Get.arguments['orderId'];
    final size = MediaQuery.of(context).size;
    controller.getSingleOrderAsync.value = controller.singleOrder(orderId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تفاصيل الطلب رقم #$orderId",
          style: TextStyle(
              fontSize: size.width * .05, fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: Container(),
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
      body: Obx(() {
        return FutureBuilder(
            future: controller.getSingleOrderAsync.value,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "الرجاء الانتظار ...",
                      style: TextStyle(fontSize: size.width * .045),
                    ),
                  ],
                ));
              }
              if (snapshot.hasError) {
                return ErrorPlaceHolder(onTap: () {
                  controller.getOrdersAsync.value =
                      controller.getOrders(orderId);
                });
              }
              return DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(tabs: [
                      Tab(
                        child: Text(
                          "التفاصيل",
                          style: TextStyle(
                              fontSize: size.width * .05, color: Colors.black),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "المنتجات",
                          style: TextStyle(
                              fontSize: size.width * .05, color: Colors.black),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "الخريطة",
                          style: TextStyle(
                              fontSize: size.width * .05, color: Colors.black),
                        ),
                      ),
                    ]),
                    Container(
                      height: size.height * .8,
                      padding: const EdgeInsets.all(15.0),
                      child: TabBarView(children: [
                        OrderDetailInfo(
                          order: controller.currentOrder!,
                        ),
                        OrderProducts(
                          order: controller.currentOrder!,
                        ),
                        OrderDetailMap(order: controller.currentOrder!)
                      ]),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
