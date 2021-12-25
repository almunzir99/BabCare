import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/custom_text_form_field.dart';
import 'package:babcare/views/components/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height * .47) + 50.0,
              width: (MediaQuery.of(context).size.width * .8) + 30.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .47,
                      width: MediaQuery.of(context).size.width * .8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text(
                            "المنزر الحسن",
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => FancyDialog(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .8,
                                        height: 470.0,
                                        child: ListView(
                                          children: [
                                            const Center(
                                              child: Text(
                                                "تعديل البيانات الشحصية",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            // ignore: prefer_const_constructors
                                            CustomTextFormField(
                                              label: "اسمك كامل",
                                              icon: LineIcons.user,
                                              value: 'المنزر الحسن',
                                            ),
                                            // ignore: prefer_const_constructors
                                            CustomTextFormField(
                                              label: "رقم تلفوني تاني",
                                              icon: LineIcons.alternatePhone,
                                              value: '0128 647 019',
                                            ),
                                            const CustomTextFormField(
                                              label: "عنوانك",
                                              icon: LineIcons.map,
                                              value: 'الخرطوم، شرق النيل',
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 30.0),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 17.0),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        icon: LineIcons.userEdit,
                                        iconSize: 40.0,
                                      ));
                            },
                            child: ListTile(
                              leading: Icon(
                                LineIcons.user,
                                size: 25.0,
                                color: primaryColor,
                              ),
                              title: const Text(
                                "معلومات الشخصية",
                                style: TextStyle(fontSize: 18.0),
                              ),
                              trailing: const Icon(
                                LineIcons.edit,
                                size: 22.0,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => FancyDialog(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .8,
                                        height: 400.0,
                                        child: ListView(
                                          children: [
                                            const Center(
                                              child: Text(
                                                "تغيير كلمة المرور",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            // ignore: prefer_const_constructors
                                            CustomTextFormField(
                                              label: "كلمة المرور",
                                              icon: LineIcons.key,
                                              value: 'almunzir99',
                                              isObscure: true,
                                            ),
                                            const CustomTextFormField(
                                              label: "اعد كلمة المرور",
                                              icon: LineIcons.map,
                                              value: 'almunzir99',
                                              isObscure: true,
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 30.0),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 17.0),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        icon: LineIcons.alternateShield,
                                        iconSize: 40.0,
                                      ));
                            },
                            child: ListTile(
                              leading: Icon(
                                LineIcons.alternateShield,
                                size: 25.0,
                                color: primaryColor,
                              ),
                              title: const Text(
                                "تغيير كلمة المرور",
                                style: TextStyle(fontSize: 18.0),
                              ),
                              trailing: const Icon(
                                LineIcons.edit,
                                size: 22.0,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed("/banks");
                            },
                            child: ListTile(
                              leading: Icon(
                                LineIcons.creditCard,
                                size: 25.0,
                                color: primaryColor,
                              ),
                              title: const Text(
                                "حساباتي البنكية",
                                style: TextStyle(fontSize: 18.0),
                              ),
                              trailing: const Icon(
                                LineIcons.angleLeft,
                                size: 22.0,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              LineIcons.map,
                              size: 25.0,
                              color: primaryColor,
                            ),
                            title: const Text(
                              "تاريح المواقع ",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            trailing: const Icon(
                              LineIcons.angleLeft,
                              size: 22.0,
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              LineIcons.alternateSignOut,
                              size: 22.0,
                              color: primaryColor,
                            ),
                            title: const Text(
                              "تسجيل الخروج",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      height: 85.0,
                      width: 85.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: primaryColor,
                        border: Border.all(color: Colors.white, width: 8.0),
                      ),
                      child: const Center(
                        child: Icon(
                          LineIcons.alternateUser,
                          size: 36.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
