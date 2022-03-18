// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          const TextSpan(
                              text: " المنزر الحسن ابراهيم ",
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
                          const TextSpan(
                              text: " +249 128 64 7019 ",
                              style: TextStyle(color: Colors.black)),
                        ], style: TextStyle(fontSize: 14.0))),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
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
                            AutoSizeText.rich(TextSpan(children: [
                              const TextSpan(
                                  text: " موقع الاستلام  : ",
                                  style: TextStyle(color: Colors.grey)),
                              const TextSpan(
                                  text: " الحاج يوسف, شارع واحد ",
                                  style: TextStyle(color: Colors.black)),
                            ], style: TextStyle(fontSize: 14.0))),
                          ],
                        ),
                        Icon(
                          LineIcons.edit,
                          color: primaryColor,
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
                          AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 10.0),
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                  color: (false)
                                      ? accentColor
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(7.0)),
                              child: Row(children: const [
                                (false)
                                    ? Icon(
                                        LineIcons.checkCircle,
                                        size: 18.0,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        LineIcons.circle,
                                        size: 18.0,
                                      ),
                                SizedBox(
                                  width: 7.0,
                                ),
                                Text(
                                  "كاش عند الاستلام",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ])),
                          Column(
                            children: ["حساب 1", "حساب 2", "حساب 3"]
                                .map((e) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 10.0),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    decoration: BoxDecoration(
                                        color: (false)
                                            ? accentColor
                                            : Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(7.0)),
                                    child: Row(children: [
                                      (false)
                                          ? const Icon(
                                              LineIcons.checkCircle,
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
                                        e,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ])))
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
                        "2300 ج.س",
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
                        "300 ج.س",
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
                        "2600 ج.س",
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
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7.0,
                        horizontal: 15.0,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(LineIcons.checkSquare, color: Colors.white),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "اكمال الطلب",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
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
