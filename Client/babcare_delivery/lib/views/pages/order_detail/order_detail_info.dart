import 'package:babcare_delivery/constants/general_constant.dart';
import 'package:babcare_delivery/models/order.dart';
import 'package:babcare_delivery/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class OrderDetailInfo extends StatelessWidget {
  const OrderDetailInfo({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
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
                        child: Text(
                          "${order.id} #",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * .06,
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
                            TextSpan(
                                text: "رقم الطلب",
                                style: TextStyle(
                                    fontSize: size.width * .04,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " # ${order.id} ",
                                style: TextStyle(
                                    fontSize: size.width * .04,
                                    fontWeight: FontWeight.bold,
                                    color: accentColor)),
                          ])),
                          const SizedBox(
                            height: 05.0,
                          ),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Icon(
                                LineIcons.calendar,
                                size: size.width * .05,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(order.createdAt!,
                                  style:
                                      TextStyle(fontSize: size.width * .035)),
                            ],
                          ),
                          const SizedBox(
                            height: 05.0,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: "  سعر الطلب   ",
                                style: TextStyle(
                                    fontSize: size.width * .04,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    "${order.total! + order.deliveryAmount!} ج.س",
                                style: TextStyle(
                                    fontSize: size.width * .04,
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
                  size: size.width * .065,
                  color: primaryColor,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                title: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "اسم المستلم : ",
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.width * .04)),
                  TextSpan(
                      text: " ${order.customer!.username} ",
                      style: TextStyle(
                          color: Colors.black, fontSize: size.width * .04)),
                ])),
              ),
              ListTile(
                leading: Icon(
                  LineIcons.phone,
                  size: size.width * .065,
                  color: primaryColor,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                title: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: " رقم الهاتف : ",
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.width * .04)),
                  TextSpan(
                      text: " ${order.customer!.phone} ",
                      style: TextStyle(
                          color: Colors.black, fontSize: size.width * .04)),
                ])),
              ),
              ListTile(
                leading: Icon(
                  LineIcons.utensils,
                  size: size.width * .065,
                  color: primaryColor,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                title: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: " سعر الطلبات  : ",
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.width * .04)),
                  TextSpan(
                      text: " ${order.total} ج.س ",
                      style: TextStyle(
                          color: Colors.black, fontSize: size.width * .04)),
                ])),
              ),
              ListTile(
                leading: Icon(
                  Icons.delivery_dining,
                  size: size.width * .065,
                  color: primaryColor,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                title: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: " سعر التوصيل  : ",
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.width * .04)),
                  TextSpan(
                      text: " ${order.deliveryAmount} ج.س ",
                      style: TextStyle(
                          color: Colors.black, fontSize: size.width * .04)),
                ])),
              ),
              ListTile(
                leading: Icon(
                  LineIcons.mapMarker,
                  size: size.width * .065,
                  color: primaryColor,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                title: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: " موقع الاستلام  : ",
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.width * .04)),
                  TextSpan(
                      text: " ${order.location} ",
                      style: TextStyle(
                          color: Colors.black, fontSize: size.width * .04)),
                ])),
              ),
              ListTile(
                leading: Icon(
                  LineIcons.moneyBill,
                  size: size.width * .065,
                  color: primaryColor,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                title: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: " 'طريقة الدفع  : ",
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.width * .04)),
                  TextSpan(
                      text:
                          " ${order.paymentType == 0 ? 'كاش' : 'دفع اونلاين'} ",
                      style: TextStyle(
                          color: Colors.black, fontSize: size.width * .04)),
                ])),
              ),
              ListTile(
                leading: Icon(
                  LineIcons.store,
                  size: size.width * .065,
                  color: primaryColor,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                title: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: " الفرع  : ",
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.width * .04)),
                  TextSpan(
                      text: "${order.branch!.title} ",
                      style: TextStyle(
                          color: Colors.black, fontSize: size.width * .04)),
                ])),
              ),
              ListTile(
                leading: Icon(
                  LineIcons.mapMarked,
                  size: size.width * .065,
                  color: primaryColor,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                title: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: " عنوان الفرع  : ",
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.width * .04)),
                  TextSpan(
                      text: "${order.branch!.location} ",
                      style: TextStyle(
                          color: Colors.black, fontSize: size.width * .04)),
                ])),
              ),
              ListTile(
                leading: Icon(
                  LineIcons.clipboardWithCheck,
                  size: size.width * .065,
                  color: primaryColor,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                title: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: " حالة الطلب  : ",
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.width * .04)),
                  TextSpan(
                      text:
                          " ${GeneralConstant.arabicOrderStatuses[order.status!]} ",
                      style: TextStyle(color: accentColor)),
                ])),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
