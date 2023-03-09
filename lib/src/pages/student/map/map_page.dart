import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(10.841327801915343, 106.80989372591378),
    zoom: 11.5,
  );

  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;
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
      _polyline.add(Polyline(
        polylineId: PolylineId('polyline'),
        visible: true,
        points: latlng,
        width: 5,
        color: Colors.orange,
      ));

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
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {_origin!, _destination!},

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
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
          onPressed: () => _googleMapController!.animateCamera(
            CameraUpdate.newCameraPosition(_initialCameraPosition),
          ),
          child: const Icon(Icons.center_focus_strong),
        ),
      ),
    );
  }

  // Future<void> _getDirections() async {
  //   // Get directions
  //   print('origin: ${_origin!.position}');
  //   print('destination: ${_destination!.position}');

  //   final directions = await DirectionsRepository().getDirections(
  //       origin: _origin!.position, destination: _destination!.position);
  //   setState(() {
  //     _info = directions;
  //   });
  // }
}
