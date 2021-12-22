import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      height: 250.0,
      margin: const EdgeInsets.only(left: 20.0),
      child: Stack(
        children: [
          Container(
            height: 250.0,
            width: 180.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0), color: Colors.white),
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
                    child: const Image(
                      height: 130.0,
                      width: 160.0,
                      image: AssetImage(
                        "assets/temp/food/image-4.png",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Product title
                    const AutoSizeText(
                      "بيتزا بالخضار",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),

                    const AutoSizeText(
                      "بيتزا ",
                      style: TextStyle(fontSize: 13.0, color: Colors.grey),
                    ),
                    //Prices
                    Column(
                      children: [
                        //Current Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AutoSizeText(
                              "1800",
                              style: TextStyle(
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
                        AutoSizeText(
                          "2200 ج.س",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey.shade500,
                              fontSize: 11.0),
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
            child: Container(
              padding: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: accentColor),
              child: const Center(
                child: Text(
                  "20%",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
          // Favourite
          Positioned(
            bottom: 10.0,
            left: 10.0,
            child: Container(
              padding: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: primaryColor),
              child: const Center(
                child: Icon(
                  LineIcons.heart,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
