import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/controllers/dimmer_controller.dart';
import 'package:babcare/controllers/favorites_controller.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/placeholders/error_placeholder.dart';
import 'package:babcare/views/components/placeholders/favorites_page_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);
  void refresh() {
    var controller = Get.put(FavoritesController());
    controller.getFavoritesAsync.value = controller.getFavorites();
    controller.getFavoritesAsync.refresh();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(FavoritesController());
    var dimmerController = Get.put(DimmerController());
    controller.getFavoritesAsync.value = controller.getFavorites();
    return Scaffold(body: Obx(() {
      return FutureBuilder(
          future: controller.getFavoritesAsync.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(top: 45.0),
                child: FavoritePageShimmer(),
              );
            } else {
              if (snapshot.hasError) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: ErrorPlaceHolder(onTap: () {
                    refresh();
                  }),
                );
              }
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        "قائمة المفضلة ",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .69,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: controller.favList
                            .map((e) => Container(
                                  height: 130.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.white),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        height: 130.0,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                child: Image(
                                                  height: 110.0,
                                                  width: 110.0,
                                                  image: NetworkImage(
                                                    e.images![0].path!,
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                //Product title
                                                AutoSizeText(
                                                  e.title!,
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),

                                                AutoSizeText(
                                                  e.categoryName!,
                                                  style: const TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.grey),
                                                ),
                                                //Prices
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    //Current Price
                                                    Row(
                                                      children: [
                                                        AutoSizeText(
                                                          "${e.price!}",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 3.0,
                                                        ),
                                                        AutoSizeText(
                                                          "ج.س",
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: primaryColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10.0,
                                        left: 10.0,
                                        child: Material(
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            onTap: () {
                                              Alert(
                                                context: context,
                                                type: AlertType.warning,
                                                title: "تنبهه",
                                                desc:
                                                    "هل انت متأكد من انك تريد حذف المنتج من المفضلة  ؟",
                                                buttons: [
                                                  DialogButton(
                                                    color: accentColor,
                                                    child: const Text(
                                                      "تمام",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                    onPressed: () async {
                                                      try {
                                                        Navigator.pop(context);
                                                        dimmerController
                                                            .showDimmer
                                                            .value = true;
                                                        await controller
                                                            .removeFromFavorite(
                                                                e.id!);
                                                        dimmerController
                                                            .showDimmer
                                                            .value = false;
                                                        refresh();
                                                      } catch (e) {
                                                        dimmerController
                                                            .showDimmer
                                                            .value = false;
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
                                                    },
                                                    width: 120,
                                                  ),
                                                  DialogButton(
                                                    color: Colors.grey,
                                                    child: const Text(
                                                      "الغاء",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    width: 120,
                                                  )
                                                ],
                                              ).show();
                                            },
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  color: primaryColor),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 7.0,
                                                        horizontal: 10.0),
                                                child: Center(
                                                  child: Row(
                                                    children: const [
                                                      Icon(
                                                        LineIcons.trash,
                                                        color: Colors.white,
                                                        size: 18.0,
                                                      ),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                        "حذف",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  ]);
            }
          });
    }));
  }
}
