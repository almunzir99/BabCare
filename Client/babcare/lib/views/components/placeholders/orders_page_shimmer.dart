import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrdersPageShimmer extends StatelessWidget {
  const OrdersPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: ListView(
            children: [1, 2, 3, 4, 5]
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 65.0,
                            width: 65.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(32.5)),
                          ),
                          const SizedBox(
                            width: 20.0,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .54,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: 40.0,
                                width: MediaQuery.of(context).size.width * 0.59,
                                margin: const EdgeInsets.only(right: 20.0),
                                child: Stack(
                                  children: [
                                    1,
                                    2,
                                    3,
                                    4,
                                  ]
                                      .map((e) => Positioned(
                                            right: (e - 1) * 25.0,
                                            child: Container(
                                              height: 40.0,
                                              width: 40.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.transparent,
                                                      width: 3.0)),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: 10.0,
                                width: MediaQuery.of(context).size.width * .54,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
