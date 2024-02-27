import 'dart:async';
import 'package:first_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTestScreen extends StatefulWidget {
  const MapTestScreen({super.key});
  @override
  State<MapTestScreen> createState() => MapTestScreenState();
}

class MapTestScreenState extends State<MapTestScreen> {
  final _controller = Completer<GoogleMapController>();
  static const _initialPosition = LatLng(23.830584, 90.350784);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  int _currentIndex = 0;
  static const _kGooglePlex = CameraPosition(
    bearing: 192.8334901395799,
    target: _initialPosition,
    tilt: 59.440717697143555,
    zoom: 13,
  );
  final List<Marker> _markers = [
    const Marker(
      markerId: MarkerId("initial location1111"),
      icon: BitmapDescriptor.defaultMarker,
      position: _initialPosition,
    ),
    Marker(
      markerId: const MarkerId("initial location222"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(
          _initialPosition.latitude + .005, _initialPosition.longitude + .005),
    ),
    Marker(
      markerId: const MarkerId("initial location333"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(
          _initialPosition.latitude + .010, _initialPosition.longitude - .010),
    ),
    Marker(
      markerId: const MarkerId("initial location444"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(
          _initialPosition.latitude + .015, _initialPosition.longitude - 0.015),
    ),
    Marker(
      markerId: const MarkerId("initial location5555"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(
          _initialPosition.latitude + .020, _initialPosition.longitude + .020),
    ),
    Marker(
      markerId: const MarkerId("initial location6666"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(
          _initialPosition.latitude + .025, _initialPosition.longitude - .025),
    ),
    Marker(
      markerId: const MarkerId("initial location777"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(
          _initialPosition.latitude + .030, _initialPosition.longitude + 0.030),
    ),
  ];

  @override
  void initState() {
    super.initState();
    addCustomIcon();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/icons/marker_icon.png")
        .then(
      (icon) => setState(() => markerIcon = icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {..._markers},
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            height: kToolbarHeight,
            child: PageView.builder(
              itemCount: _markers.length,
              onPageChanged: (index) => _onPageChange(index),
              itemBuilder: (context, i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColor.ashhLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text("Page: ${i * 10}"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPageChange(int index) async {
    final previousMarker = _markers[_currentIndex];
    _markers.removeAt(_currentIndex);
    _markers.insert(
      _currentIndex,
      Marker(
        markerId: previousMarker.markerId,
        position: previousMarker.position,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    _currentIndex = index;
    final newMarker = _markers[index];
    _markers.removeAt(index);
    _markers.insert(
      index,
      Marker(
        markerId: newMarker.markerId,
        position: newMarker.position,
        icon: markerIcon,
      ),
    );
    setState(() {});
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 192.8334901395799,
          target: _markers[index].position,
          zoom: 13,
        ),
      ),
    );
  }

  // Future<void> _goToNextPosition() async {
  //   setState(() => _isLoading = true);
  //   //final currentLocation = await _getCurrentPosition();
  //   _markerLang += .005;
  //   _destinationPosition = LatLng(
  //       _initialPosition.latitude + _markerLang, _initialPosition.longitude);
  //   _markers.add(
  //     Marker(
  //       markerId: MarkerId("destination location ${DateTime.now()}"),
  //       icon: markerIcon,
  //       position: _destinationPosition!,
  //     ),
  //   );
  //   setState(() => _isLoading = false);
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         bearing: 192.8334901395799,
  //         target: _destinationPosition!,
  //         zoom: 13,
  //       ),
  //     ),
  //   );
  // }
  // Future<Position> _getCurrentPosition() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) Future.error('Location services are disabled.');
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }
}

class MapRouteTestScreen extends StatefulWidget {
  const MapRouteTestScreen({super.key});

  @override
  State<MapRouteTestScreen> createState() => _MapRouteTestScreenState();
}

class _MapRouteTestScreenState extends State<MapRouteTestScreen> {
  late GoogleMapController mapController;
  // static const double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // static const double _destLatitude = 6.849660, _destLongitude = 3.648190;
  static const double _originLatitude = 26.48424, _originLongitude = 50.04551;
  static const double _destLatitude = 26.46423, _destLongitude = 50.06358;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyCVFllfHUhHvKxAMepxcA-72zEoFiOITVk";

  @override
  void initState() {
    super.initState();

    /// origin marker
    _addMarker(const LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(const LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                  target: LatLng(_originLatitude, _originLongitude), zoom: 15),
              myLocationEnabled: true,
              tiltGesturesEnabled: true,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: _onMapCreated,
              markers: Set<Marker>.of(markers.values),
              polylines: Set<Polyline>.of(polylines.values),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                onPressed: () {
                  print("............................");
                  _getPolyline();
                  print("............................");
                },
                icon: const Icon(Icons.macro_off),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly${DateTime.now()}");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        const PointLatLng(_originLatitude, _originLongitude),
        const PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }
  // final _controller = Completer<GoogleMapController>();
  // static const _initialPosition = LatLng(23.830584, 90.350784);
  // static const _destinyPosition = LatLng(23.8000, 90.32000);
  // BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  // static const _currentLocation = CameraPosition(
  //   bearing: 192.8334901395799,
  //   target: _initialPosition,
  //   tilt: 59.440717697143555,
  //   zoom: 13,
  // );
  // Map<PolylineId, Polyline> polylines = {};
  // List<LatLng> polylineCoordinates = [];
  // PolylinePoints polylinePoints = PolylinePoints();

  // @override
  // void initState() {
  //   super.initState();
  //   _getPolyline();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //         GoogleMap(
  //           mapType: MapType.normal,
  //           initialCameraPosition: _currentLocation,
  //           myLocationEnabled: true,
  //           tiltGesturesEnabled: true,
  //           compassEnabled: true,
  //           scrollGesturesEnabled: true,
  //           zoomGesturesEnabled: true,
  //           onMapCreated: (GoogleMapController controller) {
  //             _controller.complete(controller);
  //           },
  //           markers: {
  //             Marker(
  //               markerId: MarkerId(DateTime.now().toIso8601String()),
  //               icon: BitmapDescriptor.defaultMarker,
  //               position: _initialPosition,
  //             ),
  //             Marker(
  //               markerId: MarkerId(DateTime.now()
  //                   .add(const Duration(days: 1))
  //                   .toIso8601String()),
  //               icon: BitmapDescriptor.defaultMarker,
  //               position: _destinyPosition,
  //             ),
  //           },
  //           polylines: {...polylines.values},
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // _getPolyline() async {
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     "AIzaSyCVFllfHUhHvKxAMepxcA-72zEoFiOITVk",
  //     PointLatLng(_initialPosition.latitude, _initialPosition.longitude),
  //     PointLatLng(_destinyPosition.latitude, _destinyPosition.longitude),
  //     travelMode: TravelMode.driving,
  //     // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")],
  //   );
  //   if (result.points.isNotEmpty) {
  //     for (var point in result.points) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     }
  //   }
  //   PolylineId id = const PolylineId("poly");
  //   Polyline polyline = Polyline(
  //       polylineId: id, color: Colors.red, points: polylineCoordinates);
  //   polylines[id] = polyline;
  //   setState(() {});
  // }
}
