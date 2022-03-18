import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/custom_text_form_field.dart';
import 'package:babcare/views/components/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class BankAccountsPage extends StatelessWidget {
  const BankAccountsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("حسابتي البنكية")),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        foregroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              "عندك 5 حسابات بنكية",
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .75,
              child: ListView(
                children: [1, 2, 3, 4, 5]
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey.shade200))),
                        child: Row(
                          children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28.0),
                                  color: primaryColor),
                              child: const Center(
                                child: Icon(
                                  LineIcons.creditCardAlt,
                                  size: 28.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 25.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  "حساب $e",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text.rich(TextSpan(children: [
                                  const TextSpan(
                                      text: "رقم الحساب  :",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: " 123456 ",
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
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(LineIcons.plus),
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => FancyDialog(
                    width: MediaQuery.of(context).size.width * .8,
                    height: 470.0,
                    iconColor: accentColor,
                    child: ListView(
                      children: [
                        const Center(
                          child: Text(
                            "انشأ حساب بنكي جديد",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        // ignore: prefer_const_constructors
                        CustomTextFormField(
                          label: "اسم البنك",
                          icon: LineIcons.creditCard,
                        ),
                        const CustomTextFormField(
                          label: "اسم المالك",
                          icon: LineIcons.userTie,
                        ),
                        const CustomTextFormField(
                          label: "رقم الحساب",
                          icon: LineIcons.creditCard,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                            color: accentColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                LineIcons.check,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "اكمال",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    icon: LineIcons.creditCard,
                    iconSize: 40.0,
                  ));
        },
      ),
    );
  }
}
