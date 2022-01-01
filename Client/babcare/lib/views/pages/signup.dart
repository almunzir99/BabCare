import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      label: "اسمك",
                      icon: LineIcons.alternateUser,
                      onChange: (value) {},
                      validator: (value) {
                        if (value == null || value == '') {
                          return "الرجاء ادخال الاسم";
                        }
                      },
                    ),
                    Hero(
                      tag: "phone_field",
                      child: Material(
                        child: CustomTextFormField(
                          label: "رقم الهاتف",
                          icon: LineIcons.phone,
                          onChange: (value) {},
                          validator: (value) {
                            if (value == null || value == '') {
                              return "الرجاء ادخال رقم الهاتف";
                            }
                          },
                        ),
                      ),
                    ),
                    CustomTextFormField(
                      label: "عنوانك",
                      icon: LineIcons.mapMarked,
                      onChange: (value) {},
                      validator: (value) {
                        if (value == null || value == '') {
                          return "الرجاء ادخال العنوان";
                        }
                      },
                    ),
                    Hero(
                      tag: "password_field",
                      child: Material(
                        child: CustomTextFormField(
                          label: "كلمة المرور",
                          icon: LineIcons.key,
                          isObscure: true,
                          onChange: (value) {},
                          validator: (value) {
                            if (value == null || value == '') {
                              return "الرجاء ادخال كلمة المرور";
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Get.toNamed("/home");
                        }
                      },
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "تسجيل",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17.0),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                LineIcons.alternateSignIn,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text(" اصلا عندك  حساب ؟",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.toNamed("/login");
                          },
                          child: Text("سجل دخول",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor))),
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
