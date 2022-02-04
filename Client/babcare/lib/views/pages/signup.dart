import 'package:babcare/controllers/auth_controller.dart';
import 'package:babcare/models/customer.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/custom_text_form_field.dart';
import 'package:babcare/views/components/customer_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(AuthController());
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();

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
                      controller: _nameController,
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
                          controller: _phoneController,
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
                      controller: _locationController,
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
                          controller: _passwordController,
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
                          if (_formKey.currentState!.validate()) {
                            try {
                              var customer = Customer(
                                username: _nameController.value.text,
                                phone: _phoneController.value.text,
                                password: _passwordController.value.text,
                                email: _phoneController.value.text,
                              );
                              var result = await _controller.register(customer);
                              await Alert(
                                context: context,
                                type: AlertType.success,
                                title: "نجاح",
                                desc:
                                    "مرحب يا ${result.username}, تم التسجيل بنجاح",
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
                          }
                        },
                        text: "تسجيل",
                        icon: LineIcons.alternateSignIn,
                        width: MediaQuery.of(context).size.width * .87,
                        isLoading: _controller.isButtonLoading.value,
                      );
                    }),
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
