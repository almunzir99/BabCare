import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/controllers/discover_controller.dart';
import 'package:babcare/models/category.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/horizontal_product_card.dart';
import 'package:babcare/views/components/product_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DiscoverController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Welcoming  Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const AutoSizeText(
                            "إزيك يا",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          //User name
                          AutoSizeText(
                            "المنزر",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ],
                      ),
                      const AutoSizeText(
                        "أها عشاك الليلة شنو ؟",
                        style: TextStyle(
                            fontSize: 27.0, fontWeight: FontWeight.bold),
                      ),
                      const AutoSizeText(
                        "يلا اطلب اشهى المؤكلات من بابكير",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 35.0,
                  ),
                  // Search bar
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/search");
                    },
                    child: Hero(
                      tag: "search_bar",
                      child: Material(
                        child: Row(
                          children: [
                            //filter
                            Container(
                              height: 45.0,
                              width: 45.0,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(15.0))),
                              child: const Center(
                                child: Icon(
                                  LineIcons.filter,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // form Field
                            Expanded(
                              child: TextFormField(
                                onTap: () {
                                  Get.toNamed("/search");
                                },
                                cursorColor: primaryColor,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 15.0),
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  filled: true,
                                  hintText: "بفتش عن شنو ؟",
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(15.0))),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(15.0))),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  //Order Carousel
                  Column(
                    children: [
                      CarouselSlider(
                        carouselController: controller.carouselController,
                        items: [1, 2, 3].map((e) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              image:
                                  AssetImage("assets/temp/food/Image-$e.png"),
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                            autoPlay: true,
                            height: MediaQuery.of(context).size.height * 0.25,
                            enlargeCenterPage: true,
                            viewportFraction: 1.0,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {
                              controller.onCarouselSlide(index);
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return Center(
                          child: AnimatedSmoothIndicator(
                            activeIndex: controller.currentCarouselIndex,
                            count: 3,
                            effect: WormEffect(
                                dotColor: Colors.grey.shade200,
                                activeDotColor: primaryColor,
                                dotHeight: 10.0,
                                dotWidth: 10.0),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  //Categories Horizontal List
                  Container(
                    height: 90.0,
                    child: ListView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              radius: 20.0,
                              focusColor: Colors.white24,
                              onTap: () {
                                controller.selectCategory(index);
                              },
                              child: Obx(
                                () => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 100.0,
                                  padding: const EdgeInsets.all(10.0),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 05.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    color: (controller.selectedCategoryIndex ==
                                            index)
                                        ? primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image(
                                        height: 60.0,
                                        width: 60.0,
                                        image:
                                            AssetImage(categories[index].icon),
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      SizedBox(
                                        width: 40.0,
                                        child: AutoSizeText(
                                          categories[index].name,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: (controller
                                                          .selectedCategoryIndex ==
                                                      index)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        }),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            categories[controller.selectedCategoryIndex].name,
                            style: const TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                          AutoSizeText(
                            "عرض الكل",
                            style:
                                TextStyle(fontSize: 16.0, color: primaryColor),
                          )
                        ],
                      ),
                    );
                  }),
                  //Products Horizontal List
                  Container(
                      height: 250.0,
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed("/product_details");
                                  },
                                  child: const ProductCard()),
                            );
                          })),

                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AutoSizeText(
                          "الاكثر طلبا",
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          "عرض الكل",
                          style: TextStyle(fontSize: 16.0, color: primaryColor),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: [1, 2, 3, 4].map((e) {
                      return const HorizontalProductCard();
                    }).toList(),
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
