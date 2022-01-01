import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 20.0,
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Text(
          "قائمة المفضلة ",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height * .69,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: ListView(
          children: [1, 2, 3, 4]
              .map((e) => Container(
                    height: 130.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 130.0,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  const AutoSizeText(
                                    "بيتزا ",
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.grey),
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
                                            decoration:
                                                TextDecoration.lineThrough,
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
                          bottom: 10.0,
                          left: 10.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: primaryColor),
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
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
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
    ]));
  }
}
