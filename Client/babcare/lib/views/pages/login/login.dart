import 'package:babcare/controllers/auth_controller.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/custom_text_form_field.dart';
import 'package:babcare/views/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  LoginPage({Key? key}) : super(key: key);
  final _controller = Get.put(AuthController());
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
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
                    Hero(
                      tag: "phone_field",
                      child: Material(
                        child: CustomTextFormField(
                          controller: _phoneController,
                          label: "رقم الهاتف",
                          icon: LineIcons.phone,
                          inputType: TextInputType.number,
                          onChange: (value) {},
                          validator: (value) {
                            if (value == null || value == '') {
                              return "الرجاء ادخال رقم الهاتف";
                            }
                          },
                        ),
                      ),
                    ),
                    Hero(
                      tag: "passwordField",
                      child: Material(
                        child: CustomTextFormField(
                          controller: _passwordController,
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
                    Obx(() {
                      return CustomButton(
                        onTap: () async {
                          try {
                            var phone = _phoneController.value.text;
                            var password = _passwordController.value.text;
                            await _controller.authenticate(phone, password);
                            Get.toNamed("/home");
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
                        text: "دخول",
                        icon: LineIcons.alternateSignIn,
                        width: MediaQuery.of(context).size.width * .87,
                        isLoading: _controller.isButtonLoading.value,
                      );
                    }),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text(" ما عندك حساب ؟ ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.toNamed("/signup");
                          },
                          child: Text("سجل الان ",
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
