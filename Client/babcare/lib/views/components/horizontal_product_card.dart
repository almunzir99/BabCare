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
    return Container(
      height: 130.0,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), color: Colors.white),
      child: Stack(
        children: [
          SizedBox(
            height: 130.0,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image(
                      height: 110.0,
                      width: 110.0,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Product title
                    AutoSizeText(
                      title,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),

                    AutoSizeText(
                      subtitle,
                      style:
                          const TextStyle(fontSize: 13.0, color: Colors.grey),
                    ),
                    //Prices
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Current Price
                        Row(
                          children: [
                            AutoSizeText(
                              "$price",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
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
                        Visibility(
                          visible: oldPrice != null,
                          child: AutoSizeText(
                            "$oldPrice ج.س",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey.shade500,
                                fontSize: 11.0),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 20.0,
            right: 20.0,
            child: Visibility(
              visible: discount != null,
              child: Container(
                padding: const EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: accentColor),
                child: Center(
                  child: Text(
                    "$discount%",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
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
                    color: (!isFavorite) ? Colors.grey.shade400 : primaryColor),
                child: const Center(
                  child: Icon(
                    LineIcons.heart,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
