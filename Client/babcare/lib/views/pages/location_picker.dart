import 'package:auto_size_text/auto_size_text.dart';
import 'package:babcare/controllers/cart_controller.dart';
import 'package:babcare/models/nearest_branch_info.dart';
import 'package:babcare/services/general_service.dart';
import 'package:babcare/theme/style.dart';
import 'package:babcare/views/components/customer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';

import '../components/placeholders/error_placeholder.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({Key? key}) : super(key: key);

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  final _cartController = Get.put(CartController());
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  String locationString = '';
  LatLng currentLocation = const LatLng(15.597568, 32.5255168);
  final _service = GeneralService.instance;
  NearestBranchInfo? branch;
  bool isLoading = false;
  String? loadError;
  Future? loadEssentialAsync;

  Future _loadEssentials() async {
    // Get current user location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);
    currentLocation = LatLng(position.latitude, position.longitude);
    // get closet branch from the api
    branch = await _service.getNearestBranchInfo(
        position.latitude, position.longitude);
    // get location address name
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    locationString = placemarks.first.administrativeArea.toString() +
        ", " +
        placemarks.first.street.toString();
    _cartController.lat.value = position.latitude;
    _cartController.long.value = position.longitude;
    _cartController.deliveryPrice.value =
        _calcPrice(branch!.distance!, branch!.nearestBranch!.pricePerMeter!);
  }

  double _calcPrice(double distance, double pricePerMeter) =>
      (branch!.nearestBranch!.pricePerMeter! * (branch!.distance! / 1000))
          .roundToDouble();
  @override
  void initState() {
    loadEssentialAsync = _loadEssentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: loadEssentialAsync,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return ErrorPlaceHolder(onTap: () {});
              } else {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Map
                    GoogleMap(
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: currentLocation,
                        zoom: 15,
                      ),
                      onMapCreated: (controller) {
                        setState(() {
                          mapController = controller;
                        });
                      },
                      onCameraMove: (CameraPosition cm) {
                        cameraPosition = cm;
                      },
                      onCameraIdle: () async {
                        List<Placemark> placemarks =
                            await placemarkFromCoordinates(
                                cameraPosition!.target.latitude,
                                cameraPosition!.target.longitude);

                        try {
                          loadError = null;
                          setState(() {
                            isLoading = true;
                          });
                          branch = await _service.getNearestBranchInfo(
                              cameraPosition!.target.latitude,
                              cameraPosition!.target.longitude);
                          _cartController.lat.value =
                              cameraPosition!.target.latitude;
                          _cartController.long.value =
                              cameraPosition!.target.longitude;
                          _cartController.deliveryPrice.value = _calcPrice(
                              branch!.distance!,
                              branch!.nearestBranch!.pricePerMeter!);
                          setState(() {
                            isLoading = false;
                          });
                        } catch (e) {
                          loadError = "فشلت العملية الرجاء اعادة المحاولة";
                          setState(() {
                            isLoading = false;
                          });
                        }
                        setState(() {
                          //get place name from lat and lang
                          locationString =
                              placemarks.first.administrativeArea.toString() +
                                  ", " +
                                  placemarks.first.street.toString();
                        });
                      },
                    ),
                    // Map pin
                    Center(
                        child: SvgPicture.asset(
                      "assets/images/pin.svg",
                      color: primaryColor,
                      height: 60.0,
                      width: 60.0,
                    )),
                    // Location Information Card
                    Positioned(
                      bottom: 20.0,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            width: MediaQuery.of(context).size.width * .9,
                            height: MediaQuery.of(context).size.height * .12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        LineIcons.mapMarked,
                                        color: Colors.white,
                                        size: 27.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    child: AutoSizeText(
                                      locationString,
                                      softWrap: true,
                                      minFontSize:
                                          (MediaQuery.of(context).size.height *
                                                  .020)
                                              .roundToDouble(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * .9,
                              height: MediaQuery.of(context).size.height * .23,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: (isLoading)
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : SizedBox(
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Column(
                                                children: [
                                                  // Icon
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .044,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .044,
                                                    decoration: BoxDecoration(
                                                      color: accentColor
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        LineIcons.store,
                                                        color: accentColor,
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .025,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  // Title
                                                  AutoSizeText(
                                                    "الفرع",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700),
                                                  ),

                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .19,
                                                    child: AutoSizeText(
                                                      "${branch!.nearestBranch!.title}",
                                                      minFontSize: 12.0,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: accentColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .020)
                                                            .roundToDouble(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Column(
                                                children: [
                                                  // Icon
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .044,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .044,
                                                    decoration: BoxDecoration(
                                                      color: accentColor
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        LineIcons.rulerCombined,
                                                        color: accentColor,
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .025,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  // Title
                                                  AutoSizeText(
                                                    "المسافة",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700),
                                                  ),

                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .19,
                                                    child: AutoSizeText(
                                                      "${(branch!.distance! / 1000).toStringAsFixed(2)} KM",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: accentColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .020)
                                                            .roundToDouble(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Column(
                                                children: [
                                                  // Icon
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .044,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .044,
                                                    decoration: BoxDecoration(
                                                      color: accentColor
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        LineIcons.wavyMoneyBill,
                                                        color: accentColor,
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .025,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  // Title
                                                  AutoSizeText(
                                                    "السعر",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700),
                                                  ),

                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .19,
                                                    child: AutoSizeText(
                                                      "${_calcPrice(branch!.distance!, branch!.nearestBranch!.pricePerMeter!)} ج.س",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: accentColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .020)
                                                            .roundToDouble(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        Material(
                                          child: CustomButton(
                                              onTap: () {
                                                Get.back();
                                              },
                                              text: "تأكيد",
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .017,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .057,
                                              borderRadius: 13.0,
                                              icon: LineIcons.check,
                                              color: primaryColor,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .8),
                                        )
                                      ]),
                                    )),
                        ],
                      ),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }
}
