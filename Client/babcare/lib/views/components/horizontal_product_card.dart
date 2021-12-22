import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({
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
          Container(
            height: 130.0,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: const Image(
                      height: 110.0,
                      width: 110.0,
                      image: AssetImage(
                        "assets/temp/food/image-9.png",
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Current Price
                        Row(
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
                ),
              ],
            ),
          ),
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
