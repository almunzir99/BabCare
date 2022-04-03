import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final int? discount;
  final double? oldPrice;
  final String image;
  final bool isFavorite;
  final void Function()? onTap;
  final void Function()? onFavTap;
  const ProductCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.image,
      this.isFavorite = false,
      this.oldPrice,
      this.onFavTap,
      this.onTap,
      this.discount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.0,
      height: 250.0,
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 250.0,
              width: 180.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                children: [
                  //product image
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image(
                        height: 130.0,
                        width: 160.0,
                        image: NetworkImage(
                          image,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        children: [
                          //Current Price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                  )
                ],
              ),
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
