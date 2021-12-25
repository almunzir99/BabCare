import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_grid/responsive_grid.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RB'),
                      children: [
                    const TextSpan(text: " لقينا "),
                    TextSpan(
                        text: "4 نتايح ", style: TextStyle(color: accentColor)),
                    const TextSpan(text: " مشابهه "),
                  ])),
            ),

            //Results
            ResponsiveGridRow(
              children: [1, 2, 3, 4, 5, 6, 7, 8].map((e) {
                return ResponsiveGridCol(
                    xs: 6,
                    sm: 6,
                    md: 4,
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: ProductCard(),
                    ));
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
