import 'package:babcare/controllers/cart_controller.dart';
import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    controller.lat.value = 0.0;
    controller.long.value = 0.0;
    controller.deliveryPrice.value = 0.0;
    var result = false; // location picker page navigation result
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "سلة الطلبات",
            style: TextStyle(color: Colors.black),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            // product list
            SizedBox(
              height: MediaQuery.of(context).size.height * .66,
              child: Obx(() {
                return controller.cart.isEmpty
                    ? Center(
                        child: SvgPicture.asset(
                          "assets/images/32.svg",
                          height: MediaQuery.of(context).size.width * .9,
                          width: MediaQuery.of(context).size.width * .9,
                        ),
                      )
                    : ListView(
                        children: controller.cart
                            .map((e) => SizedBox(
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7.0, horizontal: 12.0),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  // ignore: prefer_const_constructors
                                                  child: Image(
                                                    image: NetworkImage(
                                                      "${e!.product!.images![0].path}",
                                                    ),
                                                    height: 85.0,
                                                    width: 85.0,
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
                                                    // ignore: prefer_const_constructors
                                                    Text(
                                                      "${e.product!.title}",
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    // ignore: prefer_const_constructors
                                                    Text.rich(

                                                        // ignore: prefer_const_literals_to_create_immutables, prefer_const_constructors
                                                        TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              "${e.product!.price} ج.س",
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      // ignore: prefer_const_constructors
                                                      TextSpan(
                                                          text:
                                                              "  ${e.amount}x  ",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      12.0))
                                                    ])),
                                                    const SizedBox(
                                                      height: 7.0,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .39,
                                                      child: Wrap(
                                                          children:
                                                              e.orderedOptions!
                                                                  .map(
                                                                    (o) =>
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              5.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                              "${e.product!.options![o.optionIndex!].title}"),
                                                                          const SizedBox(
                                                                            width:
                                                                                5.0,
                                                                          ),
                                                                          Container(
                                                                              decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(50.0)),
                                                                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
                                                                              // ignore: prefer_const_constructors
                                                                              child: Text(
                                                                                "${e.product!.options![o.optionIndex!].values![o.optionValueIndex!].title}",
                                                                                style: const TextStyle(color: Colors.white, fontSize: 12.0),
                                                                              )),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                  .toList()),
                                                    ),
                                                    const SizedBox(
                                                      height: 7.0,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            //Counter
                                            Container(
                                              width: 55.0,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0,
                                                        vertical: 10.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0),
                                                    border: Border.all(
                                                        color: accentColor
                                                            .withOpacity(0.3),
                                                        width: 1)),
                                                child: Column(
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .increateAmount(
                                                                e.product!.id!);
                                                      },
                                                      child: Icon(
                                                        LineIcons.plus,
                                                        color: accentColor,
                                                        size: 18.0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    // ignore: prefer_const_constructors
                                                    Text(
                                                      "${e.amount}",
                                                      style: TextStyle(
                                                          color: accentColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .decreateAmount(
                                                                e.productId!);
                                                      },
                                                      child: Center(
                                                        child: Icon(
                                                          LineIcons.minus,
                                                          color: accentColor,
                                                          size: 18.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: InkWell(
                                          onTap: () {
                                            controller
                                                .removeFormCart(e.productId!);
                                          },
                                          child: Container(
                                              height: 25.0,
                                              width: 25.0,
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.5)),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 16.0,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      );
              }),
            ),
            // total and nav bottoms
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "حساب المنتجات",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black),
                      ),
                      // ignore: prefer_const_constructors
                      Obx(() {
                        return Text(
                          "${controller.total.round()} ج.س",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: primaryColor),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Obx(() {
                    return Row(
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
                        (controller.deliveryPrice.value == 0.0)
                            ? Text(
                                "الرجاء تحديد العنوان اولا",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: accentColor),
                              )
                            : Text(
                                "${controller.deliveryPrice.value} ج.س",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: accentColor),
                              )
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(LineIcons.trash, color: Colors.white),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "افراغ السلة",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            if (controller.cart.isEmpty) {
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "تنبيه",
                                desc: "السلة فاضية , لازم تضيف منتجات اولا",
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
                              return;
                            }

                            if (controller.deliveryPrice.value == 0.0 ||
                                result != true) {
                              result = await Get.toNamed("/location_picker");
                            } else {
                              await Get.toNamed("/checkout");
                            }
                            controller.deliveryPrice.refresh();
                          },
                          child: Obx(() {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 15.0,
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: (controller.deliveryPrice.value == 0.0 ||
                                        result != true)
                                    ? accentColor
                                    : primaryColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (controller.deliveryPrice.value != 0.0 &&
                                            result)
                                        ? "متابعة"
                                        : "تحديد العنوان",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  (controller.deliveryPrice.value != 0.0)
                                      ? const Icon(LineIcons.arrowLeft,
                                          color: Colors.white)
                                      : const Icon(LineIcons.mapAlt,
                                          color: Colors.white),
                                ],
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
