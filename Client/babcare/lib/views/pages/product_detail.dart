import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/theme/style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const selectedSized = "كبير";
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              // image Viewers
              Positioned(
                top: 0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      CarouselSlider(
                        items: [
                          1,
                          2,
                          3,
                        ].map((e) {
                          return Image(
                            image: AssetImage("assets/temp/food/Image-$e.png"),
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          height: MediaQuery.of(context).size.height * 0.4,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          aspectRatio: 2.0,
                        ),
                      ),
                      // Navigation Bar
                      Positioned(
                        top: 15.0,
                        right: 20.0,
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Basket
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      LineIcons.shoppingBasket,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                //Arrow Back
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        LineIcons.angleLeft,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.62 + 30.0,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(30.0),
                          height: MediaQuery.of(context).size.height * 0.62,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(45.0),
                                  right: Radius.circular(45.0))),
                          child: ListView(
                            children: [
                              //Title
                              const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  "بيتزا خضار",
                                  style: TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              //price and Counter
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "2800 ج.س",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                  //Increment Buttons
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 25.0,
                                        width: 25.0,
                                        decoration: BoxDecoration(
                                            color: accentColor,
                                            borderRadius:
                                                BorderRadius.circular(12.5)),
                                        child: const Center(
                                          child: Icon(LineIcons.plus,
                                              size: 15.0, color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                          "1",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: accentColor),
                                        ),
                                      ),
                                      Container(
                                        height: 25.0,
                                        width: 25.0,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: accentColor),
                                            borderRadius:
                                                BorderRadius.circular(12.5)),
                                        child: Center(
                                          child: Icon(LineIcons.minus,
                                              size: 15.0, color: accentColor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              //Description
                              const AutoSizeText(
                                  "كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف "),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "الاجحام",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              SizedBox(
                                height: 40.0,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: ['كبير', "متوسط", "صغير"].map((e) {
                                    return Container(
                                      margin: const EdgeInsets.only(left: 10.0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      decoration: BoxDecoration(
                                          color: (selectedSized == e)
                                              ? accentColor
                                              : Colors.white,
                                          border: Border.all(
                                            color: accentColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Center(
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                              color: (selectedSized == e)
                                                  ? Colors.white
                                                  : accentColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 7.0,
                        right: 55.0,
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: primaryColor),
                          child: const Center(
                            child: Icon(
                              LineIcons.heart,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 20.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width * .9,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(20.0)),
                            height: 55.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  LineIcons.shoppingBasket,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10.0),
                                const Text(
                                  "اضف للسلة",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                //Divider
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  height: 18.0,
                                  width: 2.0,
                                  color: Colors.white,
                                ),
                                const Center(
                                  child: Text(
                                    "3400 ج.س",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
