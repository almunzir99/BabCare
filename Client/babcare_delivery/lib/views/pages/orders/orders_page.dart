import 'package:babcare_delivery/controllers/dimmer_controller.dart';
import 'package:babcare_delivery/controllers/orders_controller.dart';
import 'package:babcare_delivery/theme/style.dart';
import 'package:babcare_delivery/views/components/custom_button.dart';
import 'package:babcare_delivery/views/components/empty_placeholder.dart';
import 'package:babcare_delivery/views/components/error_placeholder.dart';
import 'package:babcare_delivery/views/components/orders_page_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  int currentTabStatus = 3;
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    const tabs = {"جديد": 3, "مكتمل": 4, "تم الالغاء": 5};
    final controller = Get.put(OrdersController());
    final dimmerController = Get.put(DimmerController());
    controller.getOrderAsync.value = controller.getOrders(currentTabStatus);
    var size = MediaQuery.of(context).size;
    _tabController.addListener(() {
      currentTabStatus = tabs.values.toList()[_tabController.index];
      controller.getOrderAsync.value = controller.getOrders(currentTabStatus);
    });
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            tabs: tabs.keys
                .map((e) => Tab(
                      child: Text(
                        e,
                        style: TextStyle(
                            fontSize: size.width * .05, color: Colors.black),
                      ),
                    ))
                .toList()),
        SizedBox(
          height: size.height * .72,
          child: TabBarView(
              controller: _tabController,
              children: tabs.values
                  .map((tab) => Obx(() {
                        return FutureBuilder(
                            future: controller.getOrderAsync.value,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const OrdersPageShimmer();
                              }
                              if (snapshot.hasError) {
                                return ErrorPlaceHolder(onTap: () {
                                  controller.getOrderAsync.value =
                                      controller.getOrders(currentTabStatus);
                                });
                              } else {
                                if (controller.orders.isEmpty) {
                                  return const EmptyPlaceholder();
                                }
                                return ListView.builder(
                                    itemCount: controller.orders.length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: ((context, index) {
                                      var order = controller.orders[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 15.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            onTap: () {},
                                            child: Ink(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text.rich(TextSpan(
                                                              children: [
                                                                const TextSpan(
                                                                    text:
                                                                        "طلب رقم : "),
                                                                TextSpan(
                                                                    text:
                                                                        "#${order.id}",
                                                                    style: TextStyle(
                                                                        color:
                                                                            primaryColor))
                                                              ],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: size
                                                                          .width *
                                                                      .045))),
                                                          const SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                LineIcons
                                                                    .calendarAlt,
                                                                size:
                                                                    size.width *
                                                                        .055,
                                                                color:
                                                                    accentColor,
                                                              ),
                                                              const SizedBox(
                                                                width: 7.0,
                                                              ),
                                                              Text(
                                                                "${order.createdAt}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            .04),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                LineIcons
                                                                    .mapMarked,
                                                                size:
                                                                    size.width *
                                                                        .055,
                                                                color:
                                                                    accentColor,
                                                              ),
                                                              const SizedBox(
                                                                width: 7.0,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    size.width *
                                                                        .45,
                                                                child: Text(
                                                                  "${order.location}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          size.width *
                                                                              .04),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                LineIcons
                                                                    .wavyMoneyBill,
                                                                size:
                                                                    size.width *
                                                                        .055,
                                                                color:
                                                                    accentColor,
                                                              ),
                                                              const SizedBox(
                                                                width: 7.0,
                                                              ),
                                                              Text(
                                                                "${order.total} ج.س",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            .04),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          Text(
                                                            order.paymentType ==
                                                                    0
                                                                ? 'كاش'
                                                                : 'اونلاين',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.width *
                                                                        .04),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Text.rich(TextSpan(
                                                      children: [
                                                        const TextSpan(
                                                            text:
                                                                "حالة الطلب : "),
                                                        TextSpan(
                                                            text: (order.status! >
                                                                    4)
                                                                ? 'تم الغاء الطلب'
                                                                : tabs.keys.toList()[tabs
                                                                    .values
                                                                    .toList()
                                                                    .indexOf(order
                                                                        .status!)],
                                                            style: TextStyle(
                                                                color:
                                                                    accentColor))
                                                      ],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: size.width *
                                                              .045))),
                                                  const SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  (order.status != 3)
                                                      ? Container()
                                                      : Row(
                                                          children: [
                                                            CustomButton(
                                                              text: "اكمال",
                                                              width:
                                                                  size.width *
                                                                      .38,
                                                              fontSize:
                                                                  size.width *
                                                                      .033,
                                                              height:
                                                                  size.width *
                                                                      .13,
                                                              color:
                                                                  accentColor,
                                                              onTap: () async {
                                                                try {
                                                                  Alert(
                                                                    context:
                                                                        context,
                                                                    type: AlertType
                                                                        .info,
                                                                    title:
                                                                        "تأكيد",
                                                                    desc:
                                                                        "هل انت متأكد من انك تريد اكمال الطلب ؟",
                                                                    buttons: [
                                                                      DialogButton(
                                                                        color:
                                                                            primaryColor,
                                                                        child:
                                                                            const Text(
                                                                          "اكمال",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 20),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          Navigator.pop(
                                                                              context);
                                                                          dimmerController
                                                                              .showDimmer
                                                                              .value = true;
                                                                          await controller
                                                                              .completeOrder(order.id!);
                                                                          dimmerController
                                                                              .showDimmer
                                                                              .value = false;
                                                                          controller
                                                                              .getOrderAsync
                                                                              .value = controller.getOrders(currentTabStatus);
                                                                        },
                                                                        width: size.width *
                                                                            .4,
                                                                      ),
                                                                      DialogButton(
                                                                        color: Colors
                                                                            .grey,
                                                                        child:
                                                                            const Text(
                                                                          "الغاء",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 20),
                                                                        ),
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(context),
                                                                        width: size.width *
                                                                            .4,
                                                                      )
                                                                    ],
                                                                  ).show();
                                                                } catch (e) {
                                                                  Alert(
                                                                    context:
                                                                        context,
                                                                    type: AlertType
                                                                        .error,
                                                                    title:
                                                                        "خطأ",
                                                                    desc:
                                                                        "فشلت العملية الرجاء اعاة المحاولة",
                                                                    buttons: [
                                                                      DialogButton(
                                                                        color:
                                                                            primaryColor,
                                                                        child:
                                                                            const Text(
                                                                          "تمام",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 20),
                                                                        ),
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(context),
                                                                        width: size.width *
                                                                            .4,
                                                                      )
                                                                    ],
                                                                  ).show();
                                                                }
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            CustomButton(
                                                                text: "الغاء",
                                                                width:
                                                                    size.width *
                                                                        .38,
                                                                fontSize:
                                                                    size.width *
                                                                        .033,
                                                                height:
                                                                    size.width *
                                                                        .13,
                                                                color:
                                                                    primaryColor)
                                                          ],
                                                        )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }));
                              }
                            });
                      }))
                  .toList()),
        )
      ],
    );
  }
}
