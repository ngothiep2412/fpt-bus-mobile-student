import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/models/station_model.dart';
import 'package:fbus_app/src/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';

class BookingBusPage extends StatefulWidget {
  final int quantitySeats;

  BookingBusPage({required this.quantitySeats});

  @override
  State<BookingBusPage> createState() => _BookingBusPageState();
}

class _BookingBusPageState extends State<BookingBusPage> {
  final List<Station> stationList = [
    Station(
      id: "0e9fa2f3-756b-4d73-94f7-b9a73cd5d71b",
      stationName: "FPT University",
      longitude: "106.80951580857409",
      latitude: "10.840919660389796",
      status: 1,
      createdAt: DateTime.parse("2021-02-22T05:23:14.000Z"),
      updadtedAt: DateTime.parse("2021-02-22T05:44:35.000Z"),
    ),
    Station(
      id: "0e9fa2f3-756b-4d73-94f7-b9a73cd5d71b",
      stationName: 'ĐH GTVT',
      longitude: "106.79402561754924",
      latitude: "10.846238300698467",
      status: 1,
      createdAt: DateTime.parse("2021-02-22T05:23:14.000Z"),
      updadtedAt: DateTime.parse("2021-02-22T05:44:35.000Z"),
    ),
    // Add more stations here,
  ];
  GoogleMapController? _googleMapController;
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(10.841327801915343, 106.80989372591378),
    zoom: 11.5,
  );

  late Marker _origin = Marker(
    markerId: MarkerId('FPT HCM'),
    position: LatLng(10.841327801915343, 106.80989372591378),
    infoWindow: InfoWindow(
      title: 'FPT',
      snippet: 'address',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );

  late Marker _destination = Marker(
    markerId: MarkerId('ĐH GTVT'),
    position: LatLng(10.845831460984828, 106.79441196919771),
    infoWindow: InfoWindow(
      title: 'ĐH GTVT',
      snippet: 'address',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );

  final Set<Polyline> _polyline = {};
  List<LatLng> latlng = const [
    LatLng(10.840919660389796, 106.80951580857409),
    LatLng(10.839230325598086, 106.81181329385713),
    LatLng(10.842950219081235, 106.81516116449302),
    LatLng(10.848928522404082, 106.80873595822212),
    LatLng(10.846238300698467, 106.79402561754924),
  ];

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    final markerIcon = await getMarkerIcon('assets/images/buslocation.png');

    setState(() {
      _origin = Marker(
        markerId: MarkerId('FPT HCM'),
        position: LatLng(10.841327801915343, 106.80989372591378),
        infoWindow: InfoWindow(
          title: 'FPT',
          snippet: 'address',
        ),
        icon: markerIcon,
      );

      _destination = Marker(
        markerId: MarkerId('ĐH GTVT'),
        position: LatLng(10.845831460984828, 106.79441196919771),
        infoWindow: InfoWindow(
          title: 'ĐH GTVT',
          snippet: 'address',
        ),
        icon: markerIcon,
      );

      _polyline.add(Polyline(
          polylineId: PolylineId('polyline'),
          visible: true,
          points: latlng,
          width: 5,
          color: AppColor.busdetailColor));
    });
  }

  Future<BitmapDescriptor> getMarkerIcon(String path) async {
    final image = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size.square(10),
      ),
      path,
    );
    return image;
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        titleString: 'Trip Detail',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 320,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Scaffold(
              body: Stack(
                alignment: Alignment.center,
                children: [
                  GoogleMap(
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: true,
                    initialCameraPosition: _initialCameraPosition,
                    onMapCreated: (controller) =>
                        _googleMapController = controller,
                    markers: {_origin, _destination},

                    polylines: _polyline,

                    // {
                    //     if (_info != null)
                    //       Polyline(
                    //         polylineId: const PolylineId('overview_polyline'),
                    //         color: Colors.red,
                    //         width: 5,
                    //         points: _info!.polylinePoints
                    //             .map((e) => LatLng(e.latitude, e.longitude))
                    //             .toList(),
                    //       ),
                    //   },
                  ),
                  // if (_info != null)
                  //   Positioned(
                  //     top: 20.0,
                  //     child: Container(
                  //       padding: const EdgeInsets.symmetric(
                  //         vertical: 6.0,
                  //         horizontal: 12.0,
                  //       ),
                  //       decoration: BoxDecoration(
                  //         color: Colors.yellowAccent,
                  //         borderRadius: BorderRadius.circular(20.0),
                  //         boxShadow: const [
                  //           BoxShadow(
                  //             color: Colors.black26,
                  //             offset: Offset(0, 2),
                  //             blurRadius: 6.0,
                  //           )
                  //         ],
                  //       ),
                  //       child: Text(
                  //         '${_info!.totalDistance}, ${_info!.totalDuration}',
                  //         style: const TextStyle(
                  //           fontSize: 18.0,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              floatingActionButton: Container(
                margin: EdgeInsets.only(right: 50),
                child: FloatingActionButton(
                  backgroundColor: AppColor.busdetailColor,
                  foregroundColor: Colors.white,
                  onPressed: () => _googleMapController!.animateCamera(
                    CameraUpdate.newCameraPosition(_initialCameraPosition),
                  ),
                  child: const Icon(Icons.center_focus_strong),
                ),
              ),
            ), // replace this with your map widget
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Number of seats already booked: ',
                      style: TextStyle(
                        color: AppColor.text1Color,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          '${widget.quantitySeats} / 30',
                          style: TextStyle(
                              fontSize: 20, color: AppColor.busdetailColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(Ionicons.people, color: AppColor.busdetailColor),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // add your booking logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.busdetailColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Book',
                    style: TextStyle(
                      fontSize: 14, // decrease font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'List of stations:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColor.text1Color,
              ),
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: stationList.length,
              padding: EdgeInsets.only(right: 25),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                              index == 0
                                  ? Icons.location_on
                                  : Icons.arrow_right_alt,
                              color: AppColor.busdetailColor),
                          TextButton(
                            onPressed: () =>
                                _googleMapController!.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(
                                      double.parse(stationList[index].latitude),
                                      double.parse(
                                          stationList[index].longitude)),
                                  zoom: 14.5,
                                  tilt: 10.0,
                                ),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColor.text1Color,
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            child: Text(stationList[index].stationName),
                          ),
                        ],
                      ),
                    ),
                    if (index != stationList.length - 1)
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey[400],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
