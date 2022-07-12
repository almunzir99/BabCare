// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/controllers/auth_controller.dart';
import 'package:babcare/controllers/cart_controller.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/custom_text_form_field.dart';
import 'package:babcare/views/components/custom_button.dart';

import 'package:babcare/views/components/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authController = Get.put(AuthController());
    final _cartController = Get.put(CartController());
    if (_cartController.location.value == '') {
      _cartController.location.value =
          _authController.currentCustomer.value!.location!;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "اكمال الطلب",
        ),
        foregroundColor: Colors.black,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: ListView(
          children: [
            Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "المعلومات الاساسية",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          LineIcons.alternateUser,
                          color: primaryColor,
                          size: 20.0,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        // ignore: prefer_const_literals_to_create_immutables
                        AutoSizeText.rich(TextSpan(children: [
                          const TextSpan(
                              text: "اسم المستلم : ",
                              style: TextStyle(color: Colors.grey)),
                          TextSpan(
                              text: _authController
                                  .currentCustomer.value!.username!,
                              style: TextStyle(color: Colors.black)),
                        ], style: TextStyle(fontSize: 14.0))),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          LineIcons.phone,
                          color: primaryColor,
                          size: 20.0,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        // ignore: prefer_const_literals_to_create_immutables
                        AutoSizeText.rich(TextSpan(children: [
                          const TextSpan(
                              text: " رقم الهاتف : ",
                              style: TextStyle(color: Colors.grey)),
                          TextSpan(
                              text:
                                  _authController.currentCustomer.value!.phone,
                              style: TextStyle(color: Colors.black)),
                        ], style: TextStyle(fontSize: 14.0))),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              LineIcons.mapMarked,
                              color: primaryColor,
                              size: 20.0,
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            // ignore: prefer_const_literals_to_create_immutables
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .6,
                              child: Obx(() {
                                return AutoSizeText.rich(TextSpan(children: [
                                  const TextSpan(
                                      text: " موقع الاستلام  : ",
                                      style: TextStyle(color: Colors.grey)),
                                  TextSpan(
                                      text: _cartController.location.value,
                                      style: TextStyle(color: Colors.black)),
                                ], style: TextStyle(fontSize: 14.0)));
                              }),
                            )
                          ],
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.0),
                            onTap: () async {
                              var locationController = TextEditingController(
                                  text: _cartController.location.value);
                              await showDialog(
                                  context: context,
                                  builder: (_) => FancyDialog(
                                      child: Column(children: [
                                        Text(
                                          "موقع الاستلام",
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              color: Colors.grey.shade800),
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        CustomTextFormField(
                                          label: "العنوان نصا",
                                          controller: locationController,
                                          inputType: TextInputType.multiline,
                                          maxLines: 3,
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        Material(
                                          child: CustomButton(
                                              onTap: () {
                                                _cartController.location.value =
                                                    locationController
                                                        .value.text;
                                                Navigator.of(context).pop();
                                              },
                                              text: "اكمال",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .6),
                                        )
                                      ]),
                                      icon: LineIcons.mapMarked));
                              _cartController.location.refresh();
                            },
                            child: Ink(
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Center(
                                  child: Icon(
                                    LineIcons.edit,
                                    color: primaryColor,
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              height: 230.0,
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "طريقة الدفع : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 170.0,
                      child: ListView(
                        children: [
                          Column(
                            children: [0, 1]
                                .map((e) => Obx(() {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Material(
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            onTap: () {
                                              _cartController
                                                  .paymentType.value = e;
                                            },
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                  color: _cartController
                                                              .paymentType
                                                              .value ==
                                                          e
                                                      ? accentColor
                                                      : Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0)),
                                              child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 10.0),
                                                  child: Row(children: [
                                                    _cartController.paymentType
                                                                .value ==
                                                            e
                                                        ? const Icon(
                                                            LineIcons
                                                                .checkCircle,
                                                            size: 18.0,
                                                            color: Colors.white,
                                                          )
                                                        : const Icon(
                                                            LineIcons.circle,
                                                            size: 18.0,
                                                          ),
                                                    const SizedBox(
                                                      width: 7.0,
                                                    ),
                                                    Text(
                                                      (e == 0)
                                                          ? "كاش عند الاستلام"
                                                          : "الدفع اونلاين",
                                                      style: TextStyle(
                                                          color: _cartController
                                                                      .paymentType
                                                                      .value ==
                                                                  e
                                                              ? Colors.white
                                                              : Colors.black),
                                                    ),
                                                  ])),
                                            ),
                                          ),
                                        ),
                                      );
                                    }))
                                .toList(),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              height: 190.0,
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "سعر الطلبات",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                      Text(
                        "${_cartController.total.value} ج.س",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: accentColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "سعر التوصيل",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                      Text(
                        "${_cartController.deliveryPrice} ج.س",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: accentColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "الحساب الكلي",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black),
                      ),
                      Text(
                        "${_cartController.total.value + _cartController.deliveryPrice.value} ج.س",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Obx(() {
                    return Material(
                      child: CustomButton(
                          onTap: () async {
                            try {
                              var result = await _cartController.createOrder();
                              Alert(
                                context: context,
                                title: " رقم الطلب ${result.id} ، نجاح",
                                image: SvgPicture.asset(
                                  "assets/images/426.svg",
                                  height: 130.0,
                                  width: 130.0,
                                ),
                                desc:
                                    "تم ارسال الطلب بنجاح , شوف صفحة الطلبات للمتابعة",
                                buttons: [
                                  DialogButton(
                                    color: accentColor,
                                    child: const Text(
                                      "تمام",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            } catch (e) {
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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            }
                          },
                          text: "اكمال الطلب",
                          icon: LineIcons.checkSquareAlt,
                          isLoading: _cartController.isButtonLoading.value,
                          width: MediaQuery.of(context).size.width * .9),
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
