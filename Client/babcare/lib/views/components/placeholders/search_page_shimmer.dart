import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:shimmer/shimmer.dart';

class SearchPageShimmer extends StatelessWidget {
  const SearchPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 35.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 15.0,
                  width: MediaQuery.of(context).size.width * .6,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 15.0,
                  width: MediaQuery.of(context).size.width * .4,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ],
            ),
            const SizedBox(
              height: 35.0,
            ),
            ResponsiveGridRow(
              children: [1, 2, 3, 4].map((e) {
                return ResponsiveGridCol(
                    xs: 6,
                    sm: 6,
                    md: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 180.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
