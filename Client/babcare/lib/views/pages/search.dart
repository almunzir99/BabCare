import 'package:babcare/controllers/dimmer_controller.dart';
import 'package:babcare/controllers/favorites_controller.dart';
import 'package:babcare/controllers/search_controller.dart';
import 'package:babcare/models/product.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/placeholders/dimmer.dart';
import 'package:babcare/views/components/placeholders/empty_placeholder.dart';
import 'package:babcare/views/components/placeholders/search_page_shimmer.dart';
import 'package:babcare/views/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final _controller = Get.put(SearchController());
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
    DimmerController dimmerController = Get.put(DimmerController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "البحث",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            LineIcons.arrowRight,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            ListView(
              children: [
                //search bar
                Hero(
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
                            onChanged: (value) async {
                              _controller.searchValue.value = value;
                              await _controller.search();
                            },
                            autofocus: true,
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
                // Results text
                Obx(() {
                  //else {
                  //   if (snapshot.hasError) {
                  //     return SizedBox(
                  //       height: MediaQuery.of(context).size.height * .4,
                  //       child: ErrorPlaceHolder(onTap: () {}),
                  //     );
                  //   }
                  if (_controller.isLoading.value) {
                    return const SearchPageShimmer();
                  }
                  return (_controller.products.isEmpty)
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * .7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              EmptyPlaceholder(),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 40.0),
                              child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'RB'),
                                      children: [
                                    const TextSpan(text: " لقينا "),
                                    TextSpan(
                                        text:
                                            "${_controller.products.length} نتايح ",
                                        style: TextStyle(color: accentColor)),
                                    const TextSpan(text: " مشابهه "),
                                  ])),
                            ),

                            //Results
                            ResponsiveGridRow(
                              children: _controller.products.map((product) {
                                return ResponsiveGridCol(
                                    xs: 6,
                                    sm: 6,
                                    md: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ProductCard(
                                        title: product.title!,
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
                                          await switchFavButton(
                                              product, context);
                                          _controller.products.refresh();
                                        },
                                      ),
                                    ));
                              }).toList(),
                            ),
                          ],
                        );
                })
              ],
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
      ),
    );
  }
}
