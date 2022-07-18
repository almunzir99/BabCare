import 'package:babcare_delivery/models/order.dart';
import 'package:babcare_delivery/theme/style.dart';
import 'package:flutter/material.dart';

class OrderProducts extends StatelessWidget {
  const OrderProducts({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ListView(
      children: order.products!
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(30.0),
                    child: Ink(
                      height: size.width * .34,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: size.width * .34,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
                                    child: Image(
                                      height: size.width * .3,
                                      width: size.width * .3,
                                      image: NetworkImage(
                                        e!.product!.images![0].path!,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Product title
                                    Text(
                                      e.product!.title!,
                                      style: TextStyle(
                                          fontSize: size.width * .04,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    //Prices
                                    Column(
                                      children: [
                                        //Current Price
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${e.product!.price}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * .04,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3.0,
                                            ),
                                            Text(
                                              "ج.س",
                                              style: TextStyle(
                                                fontSize: size.width * .04,
                                                color: primaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
