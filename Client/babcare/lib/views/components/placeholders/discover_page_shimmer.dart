import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverPageShimmer extends StatelessWidget {
  const DiscoverPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 70.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [1, 2, 3, 4]
                          .map(
                            (e) => Container(
                              height: 70.0,
                              width: 120.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 180.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [1, 2, 3, 4]
                          .map(
                            (e) => Container(
                              width: 180.0,
                              height: 250.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
