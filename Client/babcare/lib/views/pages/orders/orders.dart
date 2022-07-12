import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/constants/general_constant.dart';
import 'package:babcare/controllers/custom_drawer_controller.dart';
import 'package:babcare/controllers/orders_controller.dart';
import 'package:babcare/services/signalr_service.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/placeholders/error_placeholder.dart';
import 'package:babcare/views/components/placeholders/orders_page_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrdersPage extends StatelessWidget {
  final bool hideAppBar;
  const OrdersPage({Key? key, this.hideAppBar = false}) : super(key: key);
  void refresh() {
    var ordersController = Get.put(OrdersController());
    ordersController.getOrderAsync.value = ordersController.getOrders();
    ordersController.getOrderAsync.refresh();
  }

  @override
  Widget build(BuildContext context) {
    var drawerController = Get.put(CustomDrawerController());
    var ordersController = Get.put(OrdersController());
    ordersController.getOrderAsync.value = ordersController.getOrders();
    var signalRService = SignalRService.instance;
    signalRService.onNotificationRecieved((notification) {
      if (notification.module == "ORDERS") {
        refresh();
      }
    });
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
        body: Obx(() {
          return FutureBuilder(
              future: ordersController.getOrderAsync.value,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const OrdersPageShimmer();
                } else {
                  if (snapshot.hasError) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .8,
                      child: ErrorPlaceHolder(onTap: () {
                        refresh();
                      }),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          "عندك ${ordersController.orders.length} طلبات",
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: hideAppBar == true
                            ? MediaQuery.of(context).size.height * .69
                            : MediaQuery.of(context).size.height * .75,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: ordersController.orders.map((order) {
                            var date = DateTime.parse(order.createdAt!);

                            timeago.setLocaleMessages(
                                'ar', timeago.ArMessages());
                            var orderAgoDate =
                                timeago.format(date, locale: "ar");
                            return GestureDetector(
                              onTap: () {
                                ordersController.currentOrder = order;
                                Get.toNamed("/order_detail");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10.0),
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
                                        borderRadius:
                                            BorderRadius.circular(35.0),
                                        color: accentColor.withOpacity(0.3),
                                      ),
                                      child: Center(
                                        child: AutoSizeText(
                                          // ignore: unnecessary_string_interpolations
                                          "${order.id} #",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(TextSpan(children: [
                                          const TextSpan(
                                              text: "رقم الطلب",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: " #${order.id} ",
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
                                            Text(orderAgoDate),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        SizedBox(
                                          height: 40.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.62,
                                          child: Stack(
                                            children: order.products!
                                                .map((product) => Positioned(
                                                      right: order.products!
                                                              .indexOf(
                                                                  product) *
                                                          25.0,
                                                      child: Container(
                                                        height: 40.0,
                                                        width: 40.0,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 3.0)),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          child: (product!.product!
                                                                          .images ==
                                                                      null ||
                                                                  product
                                                                      .product!
                                                                      .images!
                                                                      .isEmpty)
                                                              ? Container(
                                                                  height: 40.0,
                                                                  width: 40.0,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade200,
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Icon(
                                                                    LineIcons
                                                                        .image,
                                                                    color: Colors
                                                                        .grey,
                                                                    size: 22.0,
                                                                  )),
                                                                )
                                                              : Image(
                                                                  image: NetworkImage(
                                                                      "${product.product!.images![0].path}"),
                                                                  height: 40.0,
                                                                  width: 40.0,
                                                                  fit: BoxFit
                                                                      .fill,
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
                                              text:
                                                  " ${GeneralConstant.arabicOrderStatuses[order.status!]} ",
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
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                }
              });
        }));
  }
}
