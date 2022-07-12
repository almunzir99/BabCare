import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/controllers/cart_controller.dart';
import 'package:babcare/controllers/dimmer_controller.dart';
import 'package:babcare/controllers/favorites_controller.dart';
import 'package:babcare/controllers/product_detail_controller.dart';
import 'package:babcare/models/product.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/placeholders/dimmer.dart';
import 'package:babcare/views/components/placeholders/error_placeholder.dart';
import 'package:babcare/views/components/placeholders/product_detail_shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);
  Future switchFavButton(Product product, BuildContext context) async {
    DimmerController dimmerController = Get.put(DimmerController());
    FavoritesController favController = Get.put(FavoritesController());
    try {
      dimmerController.showDimmer.value = true;
      await Future.delayed(const Duration(seconds: 1));
      if (!product.isFavorite!) {
        await favController.addToFavorite(product.id!);
      } else {
        await favController.removeFromFavorite(product.id!);
      }
      product.isFavorite = !product.isFavorite!;
      dimmerController.showDimmer.value = false;
    } catch (e) {
      dimmerController.showDimmer.value = false;
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
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductDetailController());
    DimmerController dimmerController = Get.put(DimmerController());
    var _cartController = Get.put(CartController());
    var id = (controller.currentProductId != null)
        ? controller.currentProductId
        : int.parse(Get.parameters['id']!);
    controller.currentProductId = id;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
                future: controller.getProduct(id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ProductDetailShimmer();
                  } else {
                    if (snapshot.hasError) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ErrorPlaceHolder(onTap: () {
                          // loadItemFutureBuilder(context, snapshot);
                        }),
                      );
                    } else {
                      var product = controller.product.value;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            // image Viewers
                            Positioned(
                              top: 0,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      child: Stack(
                                        children: [
                                          CarouselSlider(
                                            items:
                                                product!.images!.map((image) {
                                              return Image(
                                                image: NetworkImage(
                                                    "${image.path}"),
                                                fit: BoxFit.cover,
                                              );
                                            }).toList(),
                                            options: CarouselOptions(
                                                autoPlay: true,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.35,
                                                enlargeCenterPage: true,
                                                viewportFraction: 1.0,
                                                aspectRatio: 2.0,
                                                onPageChanged: (value,
                                                        reason) =>
                                                    controller
                                                            .currentCarouselIndex =
                                                        value),
                                          ),
                                          Positioned(
                                            bottom: 70.0,
                                            left: 20.0,
                                            child: Obx(() {
                                              return Center(
                                                child: AnimatedSmoothIndicator(
                                                  activeIndex: controller
                                                      .currentCarouselIndex,
                                                  count: product.images!.length,
                                                  effect: WormEffect(
                                                      dotColor:
                                                          Colors.grey.shade200,
                                                      activeDotColor:
                                                          primaryColor,
                                                      dotHeight: 10.0,
                                                      dotWidth: 10.0),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Navigation Bar
                                    Positioned(
                                      top: 15.0,
                                      right: 20.0,
                                      child: Center(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //Arrow Back
                                              InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Container(
                                                  height: 40.0,
                                                  width: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      LineIcons.angleRight,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //Basket
                                              InkWell(
                                                onTap: () {
                                                  Get.toNamed("/cart");
                                                },
                                                child: Obx(() {
                                                  return Container(
                                                    height: 40.0,
                                                    width: 40.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        const Center(
                                                          child: Icon(
                                                            LineIcons
                                                                .shoppingBasket,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        //badge
                                                        Positioned(
                                                          top: 3.0,
                                                          right: 3.0,
                                                          child: Container(
                                                            height: 15.0,
                                                            width: 15.0,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7.5)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                AutoSizeText(
                                                                  "${_cartController.cart.length}",
                                                                  minFontSize:
                                                                      10.0,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          10.0,
                                                                      color: Colors
                                                                          .white),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.66 +
                                        30.0,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(30.0),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.66,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left: Radius.circular(45.0),
                                                    right:
                                                        Radius.circular(45.0))),
                                        child: ListView(
                                          children: [
                                            //Title
                                            Text(
                                              "${product.title}",
                                              style: const TextStyle(
                                                  fontSize: 26.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            //price and Counter
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${product.price} ج.س",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primaryColor),
                                                ),
                                                //Increment Buttons
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: controller
                                                          .increaseAmount,
                                                      child: Container(
                                                        height: 25.0,
                                                        width: 25.0,
                                                        decoration: BoxDecoration(
                                                            color: accentColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.5)),
                                                        child: const Center(
                                                          child: Icon(
                                                              LineIcons.plus,
                                                              size: 15.0,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15.0),
                                                      child: Obx(() {
                                                        return Text(
                                                          "${controller.orderedProduct.value!.amount}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  accentColor),
                                                        );
                                                      }),
                                                    ),
                                                    GestureDetector(
                                                      onTap: controller
                                                          .decreaseAmount,
                                                      child: Container(
                                                        height: 25.0,
                                                        width: 25.0,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    accentColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.5)),
                                                        child: Center(
                                                          child: Icon(
                                                              LineIcons.minus,
                                                              size: 15.0,
                                                              color:
                                                                  accentColor),
                                                        ),
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
                                            AutoSizeText(
                                                "${product.description}"),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            (product.options!.isEmpty)
                                                ? Container()
                                                : Obx(() {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: product.options!
                                                          .map((option) {
                                                        var index = product
                                                            .options!
                                                            .indexOf(option);
                                                        var orderedOption = controller
                                                                .orderedProduct
                                                                .value!
                                                                .orderedOptions![
                                                            index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${option.title}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      17.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      primaryColor,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 20.0),
                                                              SizedBox(
                                                                height: 40.0,
                                                                child: ListView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  children: option
                                                                      .values!
                                                                      .map((e) {
                                                                    var valueIndex = option
                                                                        .values!
                                                                        .indexOf(
                                                                            e);
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        controller.selectedOption(
                                                                            index,
                                                                            valueIndex);
                                                                      },
                                                                      child:
                                                                          AnimatedContainer(
                                                                        duration:
                                                                            const Duration(milliseconds: 200),
                                                                        margin: const EdgeInsets.only(
                                                                            left:
                                                                                10.0),
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 25.0),
                                                                        decoration: BoxDecoration(
                                                                            color: (orderedOption.optionValueIndex == valueIndex)
                                                                                ? primaryColor
                                                                                : primaryColor.withOpacity(0.15),
                                                                            borderRadius: BorderRadius.circular(20.0)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            e.title!,
                                                                            style:
                                                                                TextStyle(color: (orderedOption.optionValueIndex == valueIndex) ? Colors.white : primaryColor, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    );
                                                  }),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            (product.addOns!.isEmpty)
                                                ? Container()
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "الاضافات",
                                                        style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: primaryColor,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Container(
                                                        height: 50.0,
                                                        margin: const EdgeInsets
                                                            .only(bottom: 50.0),
                                                        child: ListView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          children: product
                                                              .addOns!
                                                              .map((e) {
                                                            var index = product
                                                                .addOns!
                                                                .indexOf(e);
                                                            return GestureDetector(
                                                              onTap: () {
                                                                if (controller
                                                                    .isAddonAdded(
                                                                        index)) {
                                                                  controller
                                                                      .removeAddon(
                                                                          index);
                                                                } else {
                                                                  controller
                                                                      .addAddon(
                                                                          index);
                                                                }
                                                              },
                                                              child: Obx(() {
                                                                return AnimatedContainer(
                                                                  duration: const Duration(
                                                                      milliseconds:
                                                                          300),
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          12.0,
                                                                      vertical:
                                                                          7.0),
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          15.0),
                                                                  decoration: BoxDecoration(
                                                                      color: (controller.isAddonAdded(
                                                                              index))
                                                                          ? accentColor
                                                                          : Colors
                                                                              .grey
                                                                              .shade100,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.0)),
                                                                  child: Row(
                                                                    children: [
                                                                      (controller
                                                                              .isAddonAdded(index))
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
                                                                        width:
                                                                            7.0,
                                                                      ),
                                                                      Text(
                                                                        "${e.title}",
                                                                        style: TextStyle(
                                                                            color: controller.isAddonAdded(index)
                                                                                ? Colors.white
                                                                                : Colors.black),
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            10.0,
                                                                        width:
                                                                            2.0,
                                                                        color: controller.isAddonAdded(index)
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                        margin: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                7.0),
                                                                      ),
                                                                      Text(
                                                                        "${e.price} ج.س",
                                                                        style: TextStyle(
                                                                            color: controller.isAddonAdded(index)
                                                                                ? Colors.white
                                                                                : Colors.black),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            const SizedBox(
                                              height: 40.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 7.0,
                                      right: 55.0,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await switchFavButton(
                                              product, context);
                                          controller.product.refresh();
                                        },
                                        child: Obx(() {
                                          return Container(
                                            padding: const EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                color: (!controller.product
                                                        .value!.isFavorite!)
                                                    ? Colors.grey.shade400
                                                    : primaryColor),
                                            child: const Center(
                                              child: Icon(
                                                LineIcons.heart,
                                                color: Colors.white,
                                                size: 25.0,
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 20.0,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Center(
                                            child: Material(
                                              child: InkWell(
                                                onTap: () {
                                                  _cartController.addToCart(
                                                      controller.orderedProduct
                                                          .value!);
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: Ink(
                                                  height: 55.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .9,
                                                  decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20.0),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 10.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          LineIcons
                                                              .shoppingBasket,
                                                          color: Colors.white,
                                                        ),
                                                        const SizedBox(
                                                            width: 10.0),
                                                        const Text(
                                                          "اضف للسلة",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 17.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        //Divider
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      25.0),
                                                          height: 18.0,
                                                          width: 2.0,
                                                          color: Colors.white,
                                                        ),
                                                        Obx(() {
                                                          return Center(
                                                            child: Text(
                                                              "${controller.orderedProduct.value!.total} ج.س",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      17.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          );
                                                        })
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Obx(() {
                              return Center(
                                child: Dimmer(
                                  show: dimmerController.showDimmer.value,
                                ),
                              );
                            })
                          ],
                        ),
                      );
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
