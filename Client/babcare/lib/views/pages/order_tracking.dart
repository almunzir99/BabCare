import 'dart:math';
import 'dart:typed_data';

import 'package:babcare/controllers/orders_controller.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/dashed_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:ui' as ui;

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  final controller = Get.put(OrdersController());
  GoogleMapController? mapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyCsE5KDJqjPpbTHsQFqSjnJHclQuCBw8c4";

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor,
      {InfoWindow infoWindow = InfoWindow.noText}) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
        markerId: markerId,
        icon: descriptor,
        position: position,
        infoWindow: infoWindow);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: accentColor,
        points: polylineCoordinates,
        width: 5,
        endCap: Cap.roundCap,
        startCap: Cap.roundCap,
        geodesic: true);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline(LatLng origin, LatLng dest) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(origin.latitude, origin.longitude),
        PointLatLng(dest.latitude, dest.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  Future initMarkers() async {
    final Uint8List branchIcon =
        await getBytesFromAsset('assets/images/store.png', 160);
    final Uint8List flagIcon =
        await getBytesFromAsset('assets/images/target-2.png', 160);

    _addMarker(
        LatLng(controller.currentOrder!.branch!.lat!,
            controller.currentOrder!.branch!.long!),
        "branch",
        BitmapDescriptor.fromBytes(branchIcon));
    _addMarker(
        LatLng(controller.currentOrder!.lat!, controller.currentOrder!.long!),
        "userLocation",
        BitmapDescriptor.fromBytes(flagIcon));
    _getPolyline(
        LatLng(controller.currentOrder!.branch!.lat!,
            controller.currentOrder!.branch!.long!),
        LatLng(controller.currentOrder!.lat!, controller.currentOrder!.long!));
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

  LatLngBounds getBounds(List<Marker> markers) {
    var lngs = markers.map<double>((m) => m.position.longitude).toList();
    var lats = markers.map<double>((m) => m.position.latitude).toList();

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

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    mapController!.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      check(u, c);
    }
  }

  Future? initMarkersAsync;
  @override
  initState() {
    super.initState();
    initMarkersAsync = initMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "تابع طلب",
          ),
          foregroundColor: Colors.black,
          backgroundColor: backgroundColor,
          elevation: 0,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              FutureBuilder(
                  future: initMarkersAsync,
                  builder: (context, snapshot) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .4,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMap(
                        myLocationEnabled: true,
                        tiltGesturesEnabled: true,
                        compassEnabled: true,
                        scrollGesturesEnabled: true,
                        zoomGesturesEnabled: true,
                        markers: Set<Marker>.of(markers.values),
                        polylines: Set<Polyline>.of(polylines.values),
                        initialCameraPosition: CameraPosition(
                          target: LatLng(controller.currentOrder!.lat!,
                              controller.currentOrder!.long!),
                          zoom: 15.0,
                        ),
                        onMapCreated: (controller) {
                          mapController = controller;
                          var bound = getBounds(markers.values.toList());
                          CameraUpdate u2 =
                              CameraUpdate.newLatLngBounds(bound, 50);
                          mapController!.animateCamera(u2).then((void v) {
                            check(u2, mapController!);
                          });
                        },
                      ),
                    );
                  }),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .5,
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text.rich(TextSpan(children: [
                          const TextSpan(
                              text: " متابعة الطلب رقم ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17.0)),
                          TextSpan(
                              text: "  ${controller.currentOrder!.id} # ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: accentColor,
                                  fontSize: 17.0))
                        ])),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .38,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          color: (controller
                                                      .currentOrder!.status! >
                                                  0)
                                              ? accentColor
                                              : accentColor.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(17.5)),
                                      padding: const EdgeInsets.all(5.0),
                                      // ignore: prefer_const_constructors
                                      child: Icon(
                                        Icons.check,
                                        size: 18.0,
                                        color:
                                            (controller.currentOrder!.status! >
                                                    0)
                                                ? Colors.white
                                                : accentColor,
                                      ),
                                    ),
                                    DashSeparator(
                                      height:
                                          (MediaQuery.of(context).size.height *
                                                      .38) /
                                                  3 -
                                              55,
                                      dashHeight: 3,
                                      color: accentColor.withOpacity(0.2),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 25.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("تم استلام الطلب"),
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Icon(
                                          LineIcons.clock,
                                          color: Colors.grey.shade500,
                                          size: 17.0,
                                        ),
                                        const SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          "09:08 AM, 9 Jan 2021",
                                          style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 12.0),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          color: (controller
                                                      .currentOrder!.status! >
                                                  1)
                                              ? accentColor
                                              : accentColor.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(17.5)),
                                      padding: const EdgeInsets.all(5.0),
                                      // ignore: prefer_const_constructors
                                      child: Icon(
                                        Icons.outdoor_grill,
                                        size: 18.0,
                                        color:
                                            (controller.currentOrder!.status! >
                                                    1)
                                                ? Colors.white
                                                : accentColor,
                                      ),
                                    ),
                                    DashSeparator(
                                      height:
                                          (MediaQuery.of(context).size.height *
                                                      .38) /
                                                  3 -
                                              55,
                                      dashHeight: 3,
                                      color: accentColor.withOpacity(0.2),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 25.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("تم تحضير الطلب"),
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Icon(
                                          LineIcons.clock,
                                          color: Colors.grey.shade500,
                                          size: 17.0,
                                        ),
                                        const SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          "09:08 AM, 9 Jan 2021",
                                          style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 12.0),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          color: (controller
                                                      .currentOrder!.status! >
                                                  2)
                                              ? accentColor
                                              : accentColor.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(17.5)),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.delivery_dining,
                                        size: 18.0,
                                        color:
                                            (controller.currentOrder!.status! >
                                                    2)
                                                ? Colors.white
                                                : accentColor,
                                      ),
                                    ),
                                    DashSeparator(
                                      height:
                                          (MediaQuery.of(context).size.height *
                                                      .38) /
                                                  3 -
                                              55,
                                      dashHeight: 3,
                                      color: accentColor.withOpacity(0.2),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 25.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("قيد التوصيل"),
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Icon(
                                          LineIcons.clock,
                                          color: Colors.grey.shade500,
                                          size: 17.0,
                                        ),
                                        const SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          "09:08 AM, 9 Jan 2021",
                                          style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 12.0),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                          color: (controller
                                                      .currentOrder!.status! >
                                                  3)
                                              ? accentColor
                                              : accentColor.withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(17.5)),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        LineIcons.doubleCheck,
                                        size: 18.0,
                                        color:
                                            (controller.currentOrder!.status! >
                                                    3)
                                                ? Colors.white
                                                : accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 25.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("تم اكمال الطلب"),
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Icon(
                                          LineIcons.clock,
                                          color: Colors.grey.shade500,
                                          size: 17.0,
                                        ),
                                        const SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          "09:08 AM, 9 Jan 2021",
                                          style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 12.0),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
