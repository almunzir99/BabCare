import 'dart:math';
import 'dart:typed_data';

import 'package:babcare/controllers/orders_controller.dart';
import 'package:babcare/models/status_history.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/dashed_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:intl/intl.dart';
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
  String googleAPiKey = "AIzaSyDDkRc6lMOXlmRyWhv_2g0JbxJRQxKWsLc";

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
        LatLng(
          controller.currentOrder!.branch!.lat!,
          controller.currentOrder!.branch!.long!,
        ),
        "branch",
        BitmapDescriptor.fromBytes(branchIcon),
        infoWindow: InfoWindow(
            title: "الفرع", snippet: controller.currentOrder!.branch!.title!));
    _addMarker(
        LatLng(controller.currentOrder!.lat!, controller.currentOrder!.long!),
        "userLocation",
        BitmapDescriptor.fromBytes(flagIcon),
        infoWindow: InfoWindow(
            title: "موقعي", snippet: controller.currentOrder!.location));
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

  StatusInfo getStatusInfo(int status) {
    var history = controller.currentOrder!.history;

    if (history!.isNotEmpty) {
      for (var element in history) {
        if (element.createdAt != null) {
          var format = DateFormat.yMMMEd('ar');
          var date = DateTime.parse(element.createdAt!);
          element.formattedDate = format.format(date);
        }
      }
      if (history.last.status == 6 || history.last.status == 5) {
        if (history[history.length - 2].status == status) {
          return StatusInfo(Colors.red, Colors.white, history.last);
        } else if (history[history.length - 2].status! < status) {
          return StatusInfo(
              accentColor.withOpacity(0.3), accentColor, StatusHistory());
        } else {
          return StatusInfo(
              accentColor, Colors.white, history[history.length - 2]);
        }
      } else {
        if (history.last.status! >= status) {
          return StatusInfo(accentColor, Colors.white, history.last);
        } else {
          return StatusInfo(
              accentColor.withOpacity(0.3), accentColor, StatusHistory());
        }
      }
    }
    // throw "history should not be empty";
    return StatusInfo(
        accentColor.withOpacity(0.3), accentColor, StatusHistory());
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("ar");
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
                        onMapCreated: (controller) async {
                          mapController = controller;
                          // load style from the assets
                          var style = await DefaultAssetBundle.of(context)
                              .loadString("assets/json/map_gray_style.json");
                          mapController!.setMapStyle(style);
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
                                          color: getStatusInfo(1).background,
                                          borderRadius:
                                              BorderRadius.circular(17.5)),
                                      padding: const EdgeInsets.all(5.0),
                                      // ignore: prefer_const_constructors
                                      child: Icon(
                                          (getStatusInfo(1).history!.status ==
                                                      6 ||
                                                  getStatusInfo(1)
                                                          .history!
                                                          .status ==
                                                      5)
                                              ? LineIcons.times
                                              : Icons.check,
                                          size: 18.0,
                                          color: getStatusInfo(1).foreground),
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
                                    Text((getStatusInfo(1).history!.status ==
                                                6 ||
                                            getStatusInfo(1).history!.status ==
                                                5)
                                        ? " تم الغاء الطلب "
                                        : "تم استلام الطلب"),
                                    (getStatusInfo(1).history!.createdAt ==
                                            null)
                                        ? Container()
                                        : Row(
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
                                                getStatusInfo(1)
                                                    .history!
                                                    .formattedDate!,
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
                                          color: getStatusInfo(2).background,
                                          borderRadius:
                                              BorderRadius.circular(17.5)),
                                      padding: const EdgeInsets.all(5.0),
                                      // ignore: prefer_const_constructors
                                      child: Icon(
                                        (getStatusInfo(2).history!.status ==
                                                    6 ||
                                                getStatusInfo(2)
                                                        .history!
                                                        .status ==
                                                    5)
                                            ? LineIcons.times
                                            : Icons.outdoor_grill,
                                        size: 18.0,
                                        color: getStatusInfo(2).foreground,
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
                                    Text((getStatusInfo(2).history!.status ==
                                                6 ||
                                            getStatusInfo(2).history!.status ==
                                                5)
                                        ? " تم الغاء الطلب "
                                        : "تم تحضير الطلب"),
                                    (getStatusInfo(2).history!.createdAt ==
                                            null)
                                        ? Container()
                                        : Row(
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
                                                getStatusInfo(2)
                                                    .history!
                                                    .formattedDate!,
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
                                          color: getStatusInfo(3).background,
                                          borderRadius:
                                              BorderRadius.circular(17.5)),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        (getStatusInfo(3).history!.status ==
                                                    6 ||
                                                getStatusInfo(3)
                                                        .history!
                                                        .status ==
                                                    5)
                                            ? LineIcons.times
                                            : Icons.delivery_dining,
                                        size: 18.0,
                                        color: getStatusInfo(3).foreground,
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
                                    Text((getStatusInfo(3).history!.status ==
                                                6 ||
                                            getStatusInfo(3).history!.status ==
                                                5)
                                        ? " تم الغاء الطلب "
                                        : "قيد التوصيل"),
                                    (getStatusInfo(3).history!.createdAt ==
                                            null)
                                        ? Container()
                                        : Row(
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
                                                getStatusInfo(3)
                                                    .history!
                                                    .formattedDate!,
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
                                          color: getStatusInfo(4).background,
                                          borderRadius:
                                              BorderRadius.circular(17.5)),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                          (getStatusInfo(4).history!.status ==
                                                      6 ||
                                                  getStatusInfo(4)
                                                          .history!
                                                          .status ==
                                                      5)
                                              ? LineIcons.times
                                              : LineIcons.doubleCheck,
                                          size: 18.0,
                                          color: getStatusInfo(4).foreground),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 25.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text((getStatusInfo(4).history!.status ==
                                                6 ||
                                            getStatusInfo(4).history!.status ==
                                                5)
                                        ? " تم الغاء الطلب "
                                        : "تم اكمال الطلب"),
                                    (getStatusInfo(4).history!.createdAt ==
                                            null)
                                        ? Container()
                                        : Row(
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
                                                getStatusInfo(4)
                                                    .history!
                                                    .formattedDate!,
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

class StatusInfo {
  StatusHistory? history;
  Color? background;
  Color? foreground;
  StatusInfo(this.background, this.foreground, this.history);
}
