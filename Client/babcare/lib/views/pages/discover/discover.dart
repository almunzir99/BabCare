import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/constants/dimensions.dart';
import 'package:babcare/controllers/auth_controller.dart';
import 'package:babcare/controllers/dimmer_controller.dart';
import 'package:babcare/controllers/discover_controller.dart';
import 'package:babcare/controllers/favorites_controller.dart';
import 'package:babcare/models/product.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/horizontal_product_card.dart';
import 'package:babcare/views/components/placeholders/discover_page_shimmer.dart';
import 'package:babcare/views/components/placeholders/empty_placeholder.dart';
import 'package:babcare/views/components/placeholders/error_placeholder.dart';
import 'package:babcare/views/components/product_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  Future switchFavButton(Product product, BuildContext context) async {
    final dimmerController = Get.put(DimmerController());
    final favController = Get.put(FavoritesController());
    final size = MediaQuery.of(context).size;
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
            child: Text(
              "تمام",
              style: TextStyle(color: Colors.white, fontSize: size.width * .06),
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
    var controller = Get.put(DiscoverController());
    final _authController = Get.put(AuthController());
    final size = MediaQuery.of(context).size;
    controller.loadItemsAsync.value = controller.loadItems();
    var currentCustomer = _authController.currentCustomer.value;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
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
                          AutoSizeText(
                            "إزيك يا",
                            style: TextStyle(
                                fontSize: size.width * .06,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          //User name
                          AutoSizeText(
                            "${currentCustomer!.username}",
                            style: TextStyle(
                                fontSize: size.width * .06,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ],
                      ),
                      AutoSizeText(
                        "أها عشاك الليلة شنو ؟",
                        style: TextStyle(
                            fontSize: size.width * .068,
                            fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        "يلا اطلب اشهى المؤكلات من بابكير",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: size.width * .065,
                            fontWeight: FontWeight.bold),
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
                              height: size.width * .14,
                              width: size.width * .14,
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
                              child: SizedBox(
                                height: size.width * .14,
                                child: TextFormField(
                                  onTap: () {
                                    Get.toNamed("/search");
                                  },
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    filled: true,
                                    hintText: "بفتش عن شنو ؟",
                                    hintStyle:
                                        TextStyle(fontSize: size.width * .047),
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
                  Obx(() {
                    return FutureBuilder(
                        future: controller.loadItemsAsync.value,
                        builder: loadItemFutureBuilder);
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget loadItemFutureBuilder(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    var controller = Get.put(DiscoverController());
    var size = MediaQuery.of(context).size;
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const DiscoverPageShimmer();
    } else {
      if (snapshot.hasError) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .4,
          child: ErrorPlaceHolder(onTap: () {
            controller.loadItemsAsync.value = controller.loadItems();
          }),
        );
      }
      return Column(
        children: [
          //Order Carousel
          Column(
            children: [
              CarouselSlider(
                carouselController: controller.carouselController,
                items: controller.offers.map((offer) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      image: NetworkImage(offer.image!.path!),
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    height: size.width * .55,
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
                    count: controller.offers.length,
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
          SizedBox(
            height: size.width * .25,
            child: ListView.builder(
                itemCount: controller.categories.length,
                physics: const BouncingScrollPhysics(),
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
                          height: size.width * .25,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 05.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: (controller.selectedCategoryIndex == index)
                                ? primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                height: size.width * .22,
                                width: size.width * .22,
                                image: NetworkImage(
                                    controller.categories[index].image!.path!),
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              SizedBox(
                                width: 40.0,
                                child: AutoSizeText(
                                  controller.categories[index].title!,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          (controller.selectedCategoryIndex ==
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        controller
                            .categories[controller.selectedCategoryIndex].title!
                            .toString(),
                        style: const TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        "عرض الكل",
                        style: TextStyle(
                            fontSize: size.width * .05, color: primaryColor),
                      )
                    ],
                  ),
                ),

                //Products Horizontal List
                Container(
                    height: size.width * .69,
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    child: controller
                            .categories[controller.selectedCategoryIndex]
                            .products!
                            .isEmpty
                        ? const EmptyPlaceholder()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller
                                .categories[controller.selectedCategoryIndex]
                                .products!
                                .length,
                            itemBuilder: (context, index) {
                              var product = controller
                                  .categories[controller.selectedCategoryIndex]
                                  .products![index];
                              return Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: ProductCard(
                                  onTap: () {
                                    Get.toNamed("/product_details",
                                        parameters: {"id": "${product.id}"});
                                  },
                                  title: "${product.title}",
                                  isFavorite: product.isFavorite!,
                                  subtitle: product.categoryName!,
                                  price: (product.price! -
                                          product.price! *
                                              (product.discount! / 100))
                                      .roundToDouble(),
                                  discount: product.discount == 0.0 ||
                                          product.discount == null
                                      ? null
                                      : product.discount,
                                  oldPrice: product.discount == 0.0 ||
                                          product.discount == null
                                      ? null
                                      : product.price,
                                  image: product.images![0].path!,
                                  onFavTap: () async {
                                    await switchFavButton(product, context);
                                    controller.categories.refresh();
                                  },
                                ),
                              );
                            }))
              ],
            );
          }),
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
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
                AutoSizeText(
                  "عرض الكل",
                  style: TextStyle(
                      fontSize: size.width * .05, color: primaryColor),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Obx(() {
            return Column(
              children: controller.products.map((product) {
                return HorizontalProductCard(
                  onTap: () {
                    Get.toNamed("/product_details",
                        parameters: {"id": "${product.id}"});
                  },
                  title: product.title!,
                  subtitle: product.categoryName!,
                  price: (product.price! -
                          product.price! * (product.discount! / 100))
                      .roundToDouble(),
                  discount: product.discount == 0.0 || product.discount == null
                      ? null
                      : product.discount,
                  oldPrice: product.discount == 0.0 || product.discount == null
                      ? null
                      : product.price,
                  image: product.images![0].path!,
                  isFavorite: product.isFavorite!,
                  onFavTap: () async {
                    await switchFavButton(product, context);
                    controller.products.refresh();
                  },
                );
              }).toList(),
            );
          }),
        ],
      );
    }
  }
}
