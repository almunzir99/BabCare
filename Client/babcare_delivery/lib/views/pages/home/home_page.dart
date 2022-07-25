import 'dart:math';
import 'dart:typed_data';

import 'package:babcare_delivery/controllers/dimmer_controller.dart';
import 'package:babcare_delivery/controllers/orders_controller.dart';
import 'package:babcare_delivery/models/order.dart';
import 'package:babcare_delivery/theme/style.dart';
import 'package:babcare_delivery/views/components/custom_button.dart';
import 'package:babcare_delivery/views/components/error_placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng currentLatLng = const LatLng(0.0, 0.0);
  var location = Location();
  final OrdersController controller = Get.put(OrdersController());
  final dimmerController = Get.put(DimmerController());
  final Set<Marker> markers = {};
  final Set<Polyline> polylines = {};
  late Future initializeMapAsync;
  Future _getCurrentLocation() async {
    await requestPermission();
    var currentUserLocation = await location.getLocation();
    currentLatLng =
        LatLng(currentUserLocation.latitude!, currentUserLocation.longitude!);
    location.onLocationChanged.listen((location) {
      currentLatLng = LatLng(location.latitude!, location.longitude!);
    });
  }

  Future requestPermission() async {
    var hasPermission = await location.hasPermission();
    if (hasPermission != PermissionStatus.granted) {
      location.requestPermission().then((permissionStatus) {
        if (permissionStatus != PermissionStatus.granted) {
          Alert(
            context: context,
            type: AlertType.error,
            title: "تنبيه",
            desc: "الرجاء السماح للتطبيق باستخدام موقعك ؟",
            buttons: [
              DialogButton(
                color: primaryColor,
                child: const Text(
                  "تمام",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () async {
                  await requestPermission();
                  Navigator.pop(context);
                },
                width: 120,
              ),
              DialogButton(
                color: Colors.grey,
                child: const Text(
                  "الغاء",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
                width: 120,
              )
            ],
          ).show();
        }
      });
    }
  }

  Future addMarkers(LatLng deliveryLatLng, List<Order> orders) async {
    final Uint8List deliveryIcon =
        await getBytesFromAsset('assets/images/delivery.png', 160);
    final Uint8List targetIcon =
        await getBytesFromAsset('assets/images/target-2.png', 160);
    Marker deliveryMarker = Marker(
        markerId: const MarkerId("delivery_marker"),
        position: deliveryLatLng,
        icon: BitmapDescriptor.fromBytes(deliveryIcon),
        infoWindow: InfoWindow(
            title: "موقعي",
            snippet: "${deliveryLatLng.latitude},${deliveryLatLng.longitude}"));

    markers.add(deliveryMarker);
    for (var order in orders) {
      Marker customerMarker = Marker(
          markerId: MarkerId("${order.id}"),
          position: LatLng(order.lat!, order.long!),
          icon: BitmapDescriptor.fromBytes(targetIcon),
          infoWindow: InfoWindow(
              title: "طلب رقم : #${order.id}", snippet: order.location));
      markers.add(customerMarker);
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future getPolyLinePoints(LatLng pos1, LatLng pos2) async {
    PolylinePoints polylinePoints = PolylinePoints();

    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDDkRc6lMOXlmRyWhv_2g0JbxJRQxKWsLc",
      PointLatLng(pos1.latitude, pos1.longitude),
      PointLatLng(pos2.latitude, pos2.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      // print(result.errorMessage);
    }

    addPolyline(polylineCoordinates);
  }

  void addPolyline(List<LatLng> points) {
    polylines.add(Polyline(
        polylineId: const PolylineId("customer_deliver_polylineId"),
        color: primaryColor,
        width: 5,
        points: points,
        endCap: Cap.roundCap,
        startCap: Cap.roundCap,
        geodesic: true));
  }

  LatLngBounds _getBounds(List<LatLng> markers) {
    var lngs = markers.map<double>((m) => m.longitude).toList();
    var lats = markers.map<double>((m) => m.latitude).toList();

    double topMost = lngs.reduce(max);
    double leftMost = lats.reduce(min);
    double rightMost = lats.reduce(max);
    double bottomMost = lngs.reduce(min);

    LatLngBounds bounds = LatLngBounds(
      northeast: LatLng(rightMost, topMost),
      southwest: LatLng(leftMost, bottomMost),
    );

    return bounds;
  }

  Future _initializeMap() async {
    await _getCurrentLocation();
    await controller.getOrdersAsync.value!;
    await addMarkers(currentLatLng, controller.orders);
  }

  showTargetOrderInMap(int index) async {
    polylines.clear();
    var bounds = _getBounds([
      currentLatLng,
      LatLng(controller.orders[index].lat!, controller.orders[index].long!)
    ]);
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 120.0));
    await getPolyLinePoints(currentLatLng,
        LatLng(controller.orders[index].lat!, controller.orders[index].long!));
    setState(() {});
  }

  late GoogleMapController mapController;
  @override
  void initState() {
    super.initState();
    controller.getOrdersAsync.value = controller.getOrders(3);
    initializeMapAsync = _initializeMap();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: initializeMapAsync,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorPlaceHolder(onTap: () {
              setState(() {
                controller.getOrdersAsync.value = controller.getOrders(3);
                initializeMapAsync = _initializeMap();
              });
            });
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: size.height * .9,
              width: size.width,
              child: Stack(
                children: [
                  GoogleMap(
                    markers: markers,
                    polylines: polylines,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(0, 0),
                      zoom: 15,
                    ),
                    onMapCreated: (controller) async {
                      mapController = controller;
                      mapController.animateCamera(CameraUpdate.newLatLng(LatLng(
                          currentLatLng.latitude, currentLatLng.longitude)));
                      var style = await DefaultAssetBundle.of(context)
                          .loadString("assets/json/map_gray_style.json");
                      mapController.setMapStyle(style);
                      await showTargetOrderInMap(0);
                    },
                  ),
                  Positioned(
                    bottom: 20.0,
                    child: SizedBox(
                        width: size.width,
                        child: CarouselSlider.builder(
                          itemCount: controller.orders.length,
                          options: CarouselOptions(
                              viewportFraction: 0.85,
                              onPageChanged: (index, reason) async {
                                await showTargetOrderInMap(index);
                              }),
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            var order = controller.orders[itemIndex];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15.0),
                                  onTap: () {
                                    Get.toNamed("/order_detail",
                                        arguments: {"orderId": order.id});
                                  },
                                  child: Ink(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text.rich(TextSpan(
                                                      children: [
                                                        const TextSpan(
                                                            text: "طلب رقم : "),
                                                        TextSpan(
                                                            text:
                                                                "#${order.id}",
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor))
                                                      ],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: size.width *
                                                              .045))),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        LineIcons.calendarAlt,
                                                        size: size.width * .055,
                                                        color: accentColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 7.0,
                                                      ),
                                                      Text(
                                                        "${order.createdAt}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.width *
                                                                    .035),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        LineIcons.mapMarked,
                                                        size: size.width * .055,
                                                        color: accentColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 7.0,
                                                      ),
                                                      SizedBox(
                                                        width: size.width * .38,
                                                        child: Text(
                                                          "${order.location}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  size.width *
                                                                      .035),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        LineIcons.wavyMoneyBill,
                                                        size: size.width * .055,
                                                        color: accentColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 7.0,
                                                      ),
                                                      Text(
                                                        "${order.total} ج.س",
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.width *
                                                                    .035),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    order.paymentType == 0
                                                        ? 'كاش'
                                                        : 'اونلاين',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * .04),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          children: [
                                            CustomButton(
                                              text: "اكمال",
                                              width: size.width * .34,
                                              fontSize: size.width * .033,
                                              height: size.width * .11,
                                              padding: const EdgeInsets.all(0),
                                              borderRadius: 10.0,
                                              color: accentColor,
                                              onTap: () async {
                                                try {
                                                  Alert(
                                                    context: context,
                                                    type: AlertType.info,
                                                    title: "تأكيد",
                                                    desc:
                                                        "هل انت متأكد من انك تريد اكمال الطلب ؟",
                                                    buttons: [
                                                      DialogButton(
                                                        color: primaryColor,
                                                        child: const Text(
                                                          "اكمال",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                          dimmerController
                                                              .showDimmer
                                                              .value = true;
                                                          await controller
                                                              .completeOrder(
                                                                  order.id!);
                                                          dimmerController
                                                              .showDimmer
                                                              .value = false;
                                                          controller
                                                                  .getOrdersAsync
                                                                  .value =
                                                              controller
                                                                  .getOrders(3);
                                                        },
                                                        width: size.width * .4,
                                                      ),
                                                      DialogButton(
                                                        color: Colors.grey,
                                                        child: const Text(
                                                          "الغاء",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        width: size.width * .4,
                                                      )
                                                    ],
                                                  ).show();
                                                } catch (e) {
                                                  Alert(
                                                    context: context,
                                                    type: AlertType.error,
                                                    title: "خطأ",
                                                    desc:
                                                        "فشلت العملية الرجاء اعاة المحاولة",
                                                    buttons: [
                                                      DialogButton(
                                                        color: primaryColor,
                                                        child: const Text(
                                                          "تمام",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        width: size.width * .4,
                                                      )
                                                    ],
                                                  ).show();
                                                }
                                              },
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            CustomButton(
                                                text: "الغاء",
                                                width: size.width * .34,
                                                fontSize: size.width * .033,
                                                height: size.width * .11,
                                                padding:
                                                    const EdgeInsets.all(0),
                                                borderRadius: 10.0,
                                                color: primaryColor)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  )
                ],
              ),
            );
          } else {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "الرجاء الانتظار ...",
                  style: TextStyle(fontSize: size.width * .045),
                ),
              ],
            ));
          }
        });
  }
}
