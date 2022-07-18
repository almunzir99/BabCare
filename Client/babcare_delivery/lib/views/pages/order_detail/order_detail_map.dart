import 'dart:math';
import 'dart:typed_data';

import 'package:babcare_delivery/models/order.dart';
import 'package:babcare_delivery/theme/style.dart';
import 'package:babcare_delivery/views/components/error_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class OrderDetailMap extends StatefulWidget {
  final Order order;
  const OrderDetailMap({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailMap> createState() => _OrderDetailMapState();
}

class _OrderDetailMapState extends State<OrderDetailMap> {
  GoogleMapController? mapController;
  final Set<Marker> markers = {};
  final Set<Polyline> polylines = {};

  LatLng currentLatLng = const LatLng(0.0, 0.0);
  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  addMarkers(LatLng deliveryLatLng, LatLng customerLatLng) async {
    final Uint8List deliveryIcon =
        await getBytesFromAsset('assets/images/delivery.png', 160);
    final Uint8List targetIcon =
        await getBytesFromAsset('assets/images/target-2.png', 160);
    Marker deliveryMarker = Marker(
        markerId: const MarkerId("delivery_marker"),
        position: deliveryLatLng,
        icon: BitmapDescriptor.fromBytes(deliveryIcon),
        infoWindow: const InfoWindow(title: "موقعي"));
    Marker customerMarker = Marker(
        markerId: const MarkerId("customer_marker"),
        position: customerLatLng,
        icon: BitmapDescriptor.fromBytes(targetIcon),
        infoWindow: const InfoWindow(title: "موقع العميل"));
    markers.add(deliveryMarker);
    markers.add(customerMarker);
  }

  getPolyLinePoints(LatLng pos1, LatLng pos2) async {
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

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future _configureMapUtils() async {
    var currentPos = await _getCurrentPosition();
    currentLatLng = LatLng(currentPos.latitude, currentPos.longitude);
    await addMarkers(LatLng(currentLatLng.latitude, currentLatLng.longitude),
        LatLng(widget.order.lat!, widget.order.long!));
    await getPolyLinePoints(
        LatLng(currentLatLng.latitude, currentLatLng.longitude),
        LatLng(widget.order.lat!, widget.order.long!));
  }

  LatLngBounds _getBounds(List<Marker> markers) {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _configureMapUtils(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                GoogleMap(
                  markers: markers,
                  polylines: polylines,
                  initialCameraPosition:
                      const CameraPosition(target: LatLng(0, 0), zoom: 15),
                  onMapCreated: (controller) async {
                    mapController = controller;
                    mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(
                        currentLatLng.latitude, currentLatLng.longitude)));
                    var style = await DefaultAssetBundle.of(context)
                        .loadString("assets/json/map_gray_style.json");
                    mapController!.setMapStyle(style);
                    var bounds = _getBounds(markers.toList());
                    mapController!
                        .moveCamera(CameraUpdate.newLatLngBounds(bounds, 30.0));
                  },
                )
              ],
            );
          }
          if (snapshot.hasError) {
            return ErrorPlaceHolder(onTap: () {});
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
