import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrdersPageShimmer extends StatelessWidget {
  const OrdersPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
          children: [1, 2, 3, 4, 5]
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [1, 2, 3]
                                  .map(
                                    (e) => Container(
                                      height: 10.0,
                                      width: MediaQuery.of(context).size.width *
                                          .38,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [1, 2]
                                  .map(
                                    (e) => Container(
                                      height: 10.0,
                                      width: MediaQuery.of(context).size.width *
                                          .38,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
              .toList()),
    );
  }
}
