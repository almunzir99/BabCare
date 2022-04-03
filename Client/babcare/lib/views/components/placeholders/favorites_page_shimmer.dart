import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FavoritePageShimmer extends StatelessWidget {
  const FavoritePageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        children: [1, 2, 3, 4]
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 110.0,
                        width: 110.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        children: [1, 2, 3]
                            .map(
                              (e) => Container(
                                height: 10.0,
                                width: MediaQuery.of(context).size.width * .35,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
