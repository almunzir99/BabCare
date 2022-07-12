import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HorizontalProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final int? discount;
  final double? oldPrice;
  final String image;
  final bool isFavorite;
  final void Function()? onTap;
  final void Function()? onFavTap;
  const HorizontalProductCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.image,
    this.oldPrice,
    this.onFavTap,
    this.onTap,
    this.discount,
    this.isFavorite = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30.0),
          child: Ink(
            height: size.width * .34,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0), color: Colors.white),
            child: Stack(
              children: [
                SizedBox(
                  height: size.width * .34,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Image(
                            height: size.width * .3,
                            width: size.width * .3,
                            image: NetworkImage(
                              image,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Product title
                          AutoSizeText(
                            title,
                            style: TextStyle(
                                fontSize: size.width * .04,
                                fontWeight: FontWeight.bold),
                          ),

                          AutoSizeText(
                            subtitle,
                            style: TextStyle(
                                fontSize: size.width * .033,
                                color: Colors.grey),
                          ),
                          //Prices
                          Column(
                            children: [
                              //Current Price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    "$price",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * .04,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3.0,
                                  ),
                                  AutoSizeText(
                                    "ج.س",
                                    style: TextStyle(
                                      fontSize: size.width * .04,
                                      color: primaryColor,
                                    ),
                                  )
                                ],
                              ),
                              Visibility(
                                visible: oldPrice != null,
                                child: AutoSizeText(
                                  "$oldPrice ج.س",
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey.shade500,
                                    fontSize: size.width * .028,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                //Discount Padge
                Positioned(
                  top: 20.0,
                  right: 20.0,
                  child: Visibility(
                    visible: discount != null,
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7.0, vertical: 9.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: accentColor),
                        child: Center(
                          child: Text(
                            "$discount% ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: size.width * .038),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Favourite
                Positioned(
                  bottom: 10.0,
                  left: 10.0,
                  child: GestureDetector(
                    onTap: onFavTap,
                    child: Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: (!isFavorite)
                              ? Colors.grey.shade400
                              : primaryColor),
                      child: Center(
                        child: Icon(
                          LineIcons.heart,
                          color: Colors.white,
                          size: size.width * .05,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
