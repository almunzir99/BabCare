import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * .9,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * .9,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 15.0,
                            width: MediaQuery.of(context).size.width * .6,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
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
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 70.0,
                      ),
                      Column(
                        children: [1, 2, 3, 4, 5]
                            .map(
                              (e) => Container(
                                height: 15.0,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 50.0,
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [1, 2, 3, 4]
                              .map(
                                (e) => Container(
                                  width: 120.0,
                                  height: 50.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
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
                  )))
        ]));
  }
}
