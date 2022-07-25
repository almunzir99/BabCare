import 'package:babcare_delivery/controllers/auth_controller.dart';
import 'package:babcare_delivery/models/delivery.dart';
import 'package:babcare_delivery/theme/style.dart';
import 'package:babcare_delivery/views/components/custom_button.dart';
import 'package:babcare_delivery/views/components/custom_text_form_field.dart';
import 'package:babcare_delivery/views/components/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(AuthController());
    var customer = _controller.currentDelivery.value!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height * .38) + 50.0,
              width: (MediaQuery.of(context).size.width * .8) + 30.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .38,
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
                          Text(
                            "${customer.username}",
                            style: const TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          InkWell(
                            onTap: () {
                              final _formKey = GlobalKey<FormState>();

                              var nameController = TextEditingController(
                                  text: customer.username);
                              var locationController = TextEditingController(
                                  text: customer.location);
                              var phoneController =
                                  TextEditingController(text: customer.phone);
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
                                            Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  CustomTextFormField(
                                                    label: "اسمك كامل",
                                                    icon: LineIcons.user,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value == '') {
                                                        return "الرجاء ادخال الاسم";
                                                      }
                                                    },
                                                    controller: nameController,
                                                  ),
                                                  // ignore: prefer_const_constructors
                                                  CustomTextFormField(
                                                    label: "رقم تلفوني ",
                                                    icon: LineIcons
                                                        .alternatePhone,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value == '') {
                                                        return "الرجاء ادخال رقم الهاتف";
                                                      }
                                                    },
                                                    controller: phoneController,
                                                  ),
                                                  CustomTextFormField(
                                                    label: "عنوانك",
                                                    icon: LineIcons.map,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value == '') {
                                                        return "الرجاء ادخال العنوان";
                                                      }
                                                    },
                                                    controller:
                                                        locationController,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Obx(() {
                                              return Material(
                                                child: CustomButton(
                                                  onTap: () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      try {
                                                        var newDelivery =
                                                            Delivery(
                                                          username:
                                                              nameController
                                                                  .value.text,
                                                          phone: phoneController
                                                              .value.text,
                                                          location:
                                                              locationController
                                                                  .value.text,
                                                        );
                                                        await _controller
                                                            .updateProfile(
                                                                customer.id!,
                                                                newDelivery);
                                                        await Alert(
                                                          context: context,
                                                          type:
                                                              AlertType.success,
                                                          title: "نجاح",
                                                          desc:
                                                              "تم تعديل البيانات بنجاح",
                                                          buttons: [
                                                            DialogButton(
                                                              color:
                                                                  primaryColor,
                                                              child: const Text(
                                                                "تمام",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
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
                                                          desc:
                                                              "فشلت العملية الرجاء اعاة المحاولة",
                                                          buttons: [
                                                            DialogButton(
                                                              color:
                                                                  primaryColor,
                                                              child: const Text(
                                                                "تمام",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              width: 120,
                                                            )
                                                          ],
                                                        ).show();
                                                      }
                                                    }
                                                  },
                                                  text: "اكمال",
                                                  icon: LineIcons.check,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .87,
                                                  isLoading: _controller
                                                      .isButtonLoading.value,
                                                ),
                                              );
                                            }),
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
                          ListTile(
                            onTap: () {
                              Get.offNamed("/login");
                            },
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
