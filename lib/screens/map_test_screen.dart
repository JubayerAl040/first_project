import 'dart:async';
import 'package:first_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

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
  const MapRouteTestScreen(
      {super.key,
      required this.currentPosition,
      required this.destinyPosition,
      required this.originIcon,
      required this.desinyIcon});
  final LatLng currentPosition;
  final LatLng destinyPosition;
  final BitmapDescriptor originIcon;
  final BitmapDescriptor desinyIcon;

  @override
  State<MapRouteTestScreen> createState() => _MapRouteTestScreenState();
}

class _MapRouteTestScreenState extends State<MapRouteTestScreen> {
  late GoogleMapController _mapController;
  double _originLatitude = 0, _originLongitude = 0;
  double _destinyLatitude = 0, _destinyLongitude = 0;
  List<LatLng> _polylineCoordinates = [];
  BitmapDescriptor _originIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _destinyIcon = BitmapDescriptor.defaultMarker;
  String googleAPiKey = "AIzaSyDaIOHljSeGOAM5dEgOecGc4GE1NfSWZQg";
  late StreamSubscription<Position> _positionStream;

  @override
  void initState() {
    super.initState();
    _originLatitude = widget.currentPosition.latitude;
    _originLongitude = widget.currentPosition.longitude;
    _destinyLatitude = widget.destinyPosition.latitude;
    _destinyLongitude = widget.destinyPosition.longitude;
    _originIcon = widget.originIcon;
    _destinyIcon = widget.desinyIcon;
    Logger().e("""
      $_originLatitude 
    $_originLongitude 
    $_destinyLatitude
    $_destinyLongitude 
    """);
    WidgetsBinding.instance.addPostFrameCallback((_) => _determinePosition());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(_originLatitude, _originLongitude),
              zoom: 13,
            ),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (controlller) => _mapController = controlller,
            markers: {
              Marker(
                markerId: const MarkerId("currentPosition"),
                icon: _originIcon,
                position: LatLng(_originLatitude, _originLongitude),
              ),
              Marker(
                markerId: const MarkerId("destinyPosition"),
                icon: _destinyIcon,
                position: LatLng(_destinyLatitude, _destinyLongitude),
              ),
            },
            polylines: {
              Polyline(
                polylineId: PolylineId(DateTime.now().toIso8601String()),
                color: Colors.black,
                points: _polylineCoordinates,
                startCap: Cap.roundCap,
                endCap: Cap.roundCap,
                width: 6,
              )
            },
          ),
        ],
      )),
    );
  }

  void _getPolyline(Position position) async {
    _originLatitude = position.latitude;
    _originLongitude = position.longitude;
    _polylineCoordinates = [];
    final result = await PolylinePoints().getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destinyLatitude, _destinyLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    setState(() {});
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(_originLatitude, _originLongitude), zoom: 13),
      ),
    );
  }

  Future<void> _determinePosition() async {
    _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    )).listen((Position? position) {
      if (position != null) {
        _getPolyline(position);
      }
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    _positionStream.cancel();
    super.dispose();
  }
}
