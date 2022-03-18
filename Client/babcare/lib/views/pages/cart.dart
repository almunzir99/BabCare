import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: ListView(
                children: [1, 2, 3, 4]
                    .map((e) => SizedBox(
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7.0, horizontal: 12.0),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              BorderRadius.circular(20.0),
                                          // ignore: prefer_const_constructors
                                          child: Image(
                                            image: const AssetImage(
                                              "assets/temp/food/image-4.png",
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
                                              "بيتزا خضار",
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
                                                  text: "2300 ج.س",
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              // ignore: prefer_const_constructors
                                              TextSpan(
                                                  text: "  2x  ",
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12.0))
                                            ])),
                                            const SizedBox(
                                              height: 7.0,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0,
                                                        vertical: 2.0),
                                                // ignore: prefer_const_constructors
                                                child: Text(
                                                  "كبير",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.0),
                                                )),
                                            const SizedBox(
                                              height: 7.0,
                                            ),
                                            // SizedBox(
                                            //   width: MediaQuery.of(context)
                                            //           .size
                                            //           .width *
                                            //       .39,
                                            //   child: Wrap(
                                            //     runAlignment:
                                            //         WrapAlignment.start,
                                            //     children: options
                                            //         .map((e) => Container(
                                            //             decoration: BoxDecoration(
                                            //                 color: accentColor
                                            //                     .withOpacity(
                                            //                         0.3),
                                            //                 borderRadius:
                                            //                     BorderRadius
                                            //                         .circular(
                                            //                             50.0)),
                                            //             padding:
                                            //                 const EdgeInsets
                                            //                         .symmetric(
                                            //                     horizontal:
                                            //                         15.0,
                                            //                     vertical: 2.0),
                                            //             margin: const EdgeInsets
                                            //                     .only(
                                            //                 left: 5.0,
                                            //                 bottom: 5.0),
                                            //             // ignore: prefer_const_constructors
                                            //             child: Text(
                                            //               "${e.name}",
                                            //               style: TextStyle(
                                            //                   color:
                                            //                       accentColor,
                                            //                   fontSize: 12.0),
                                            //             )))
                                            //         .toList(),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ],
                                    ),
                                    //Counter
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 10.0),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          border: Border.all(
                                              color:
                                                  accentColor.withOpacity(0.3),
                                              width: 1)),
                                      child: Column(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Icon(
                                            LineIcons.plus,
                                            color: accentColor,
                                            size: 18.0,
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          // ignore: prefer_const_constructors
                                          Text(
                                            "2",
                                            style: TextStyle(
                                                color: accentColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Icon(
                                            LineIcons.minus,
                                            color: accentColor,
                                            size: 18.0,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                    height: 25.0,
                                    width: 25.0,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(12.5)),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16.0,
                                    )),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
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
                        "الحساب الكلي",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black),
                      ),
                      // ignore: prefer_const_constructors
                      Text(
                        "22300 ج.س",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7.0,
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
                      // ignore: prefer_const_constructors
                      Text(
                        "200 ج.س",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: accentColor),
                      ),
                    ],
                  ),
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
                          onTap: () {
                            Get.toNamed("/checkout");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 15.0,
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "متابعة",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(LineIcons.arrowLeft, color: Colors.white),
                              ],
                            ),
                          ),
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
