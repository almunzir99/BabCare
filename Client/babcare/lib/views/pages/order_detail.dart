// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/controllers/orders_controller.dart';
import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constants/general_constant.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());
    var date = DateTime.parse(controller.currentOrder!.createdAt!);
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    var orderAgoDate = timeago.format(date, locale: "ar");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تفاصيل الطلب",
        ),
        foregroundColor: Colors.black,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            //
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Row(
                      children: [
                        Container(
                          height: 75.0,
                          width: 75.0,
                          padding: const EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: accentColor.withOpacity(0.3),
                          ),
                          child: Center(
                            child: AutoSizeText(
                              "${controller.currentOrder!.id} #",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                                color: accentColor,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(TextSpan(children: [
                                const TextSpan(
                                    text: "رقم الطلب",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: " # ${controller.currentOrder!.id} ",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: accentColor)),
                              ])),
                              const SizedBox(
                                height: 05.0,
                              ),
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Icon(
                                    LineIcons.calendar,
                                    size: 16.0,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(orderAgoDate,
                                      style: TextStyle(fontSize: 12.0)),
                                ],
                              ),
                              const SizedBox(
                                height: 05.0,
                              ),
                              Text.rich(TextSpan(children: [
                                const TextSpan(
                                    text: "  سعر الطلب   ",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        "${controller.currentOrder!.total! + controller.currentOrder!.deliveryAmount!} ج.س",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: accentColor)),
                              ])),
                            ])
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(
                      LineIcons.alternateUser,
                      color: primaryColor,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    title: AutoSizeText.rich(TextSpan(children: [
                      const TextSpan(
                          text: "اسم المستلم : ",
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text:
                              " ${controller.currentOrder!.customer!.username} ",
                          style: TextStyle(color: Colors.black)),
                    ])),
                  ),
                  ListTile(
                    leading: Icon(
                      LineIcons.phone,
                      color: primaryColor,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    title: AutoSizeText.rich(TextSpan(children: [
                      const TextSpan(
                          text: " رقم الهاتف : ",
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: " ${controller.currentOrder!.customer!.phone} ",
                          style: TextStyle(color: Colors.black)),
                    ])),
                  ),
                  ListTile(
                    leading: Icon(
                      LineIcons.utensils,
                      color: primaryColor,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    title: AutoSizeText.rich(TextSpan(children: [
                      const TextSpan(
                          text: " سعر الطلبات  : ",
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: " ${controller.currentOrder!.total} ج.س ",
                          style: TextStyle(color: Colors.black)),
                    ])),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.delivery_dining,
                      color: primaryColor,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    title: AutoSizeText.rich(TextSpan(children: [
                      const TextSpan(
                          text: " سعر التوصيل  : ",
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text:
                              " ${controller.currentOrder!.deliveryAmount} ج.س ",
                          style: TextStyle(color: Colors.black)),
                    ])),
                  ),
                  ListTile(
                    leading: Icon(
                      LineIcons.mapMarker,
                      color: primaryColor,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    title: AutoSizeText.rich(TextSpan(children: [
                      const TextSpan(
                          text: " موقع الاستلام  : ",
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: " ${controller.currentOrder!.location} ",
                          style: TextStyle(color: Colors.black)),
                    ])),
                  ),
                  ListTile(
                    leading: Icon(
                      LineIcons.moneyBill,
                      color: primaryColor,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    title: AutoSizeText.rich(TextSpan(children: [
                      const TextSpan(
                          text: " 'طريقة الدفع  : ",
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text:
                              " ${controller.currentOrder!.paymentType == 0 ? 'كاش' : 'دفع اونلاين'} ",
                          style: TextStyle(color: Colors.black)),
                    ])),
                  ),
                  ListTile(
                    leading: Icon(
                      LineIcons.store,
                      color: primaryColor,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    title: AutoSizeText.rich(TextSpan(children: [
                      const TextSpan(
                          text: " الفرع  : ",
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: "${controller.currentOrder!.branch!.title} ",
                          style: TextStyle(color: Colors.black)),
                    ])),
                  ),
                  ListTile(
                    leading: Icon(
                      LineIcons.mapMarked,
                      color: primaryColor,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    title: AutoSizeText.rich(TextSpan(children: [
                      const TextSpan(
                          text: " عنوان الفرع  : ",
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: "${controller.currentOrder!.branch!.location} ",
                          style: TextStyle(color: Colors.black)),
                    ])),
                  ),
                  ListTile(
                    leading: Icon(
                      LineIcons.clipboardWithCheck,
                      color: primaryColor,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    title: AutoSizeText.rich(TextSpan(children: [
                      const TextSpan(
                          text: " حالة الطلب  : ",
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text:
                              " ${GeneralConstant.arabicOrderStatuses[controller.currentOrder!.status!]} ",
                          style: TextStyle(color: accentColor)),
                    ])),
                    trailing: GestureDetector(
                      onTap: () {
                        Get.toNamed("/order_tracking");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        decoration: BoxDecoration(
                            color: accentColor,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          "تابع طلبك",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              "قائمة المنتجات",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 80.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: controller.currentOrder!.products!
                    .map((product) => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 12.0),
                        margin: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: (product!.product!.images == null ||
                                            product.product!.images!.isEmpty)
                                        ? Container(
                                            height: 40.0,
                                            width: 40.0,
                                            color: Colors.grey.shade200,
                                            child: const Center(
                                                child: Icon(
                                              LineIcons.image,
                                              color: Colors.grey,
                                              size: 22.0,
                                            )),
                                          )
                                        : Image(
                                            image: NetworkImage(
                                              "${product.product!.images![0].path}",
                                            ),
                                            height: 60.0,
                                            width: 60.0,
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${product.product!.title}",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text.rich(TextSpan(children: [
                                        TextSpan(
                                            text:
                                                "${product.product!.price} ج.س",
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: "  ${product.amount}x  ",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0))
                                      ])),
                                      const SizedBox(
                                        height: 7.0,
                                      ),
                                      const SizedBox(
                                        height: 7.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ])))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
