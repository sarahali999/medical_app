import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MapController _mapController = MapController();
  LatLng currentLocation = LatLng(0, 0);
  TextEditingController searchController = TextEditingController();
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _locateUser();
    _addMarkers();

  }
  _addMarkers() {
    markers = [
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(32.6076326,44.093935),
        child: Container(
          child: Icon(Icons.location_on, size: 50.0, color: Colors.red),
        ),
      ),
    Marker(
    width: 80.0,
    height: 80.0,
    point: LatLng(32.6185146,44.0812222),
    child: Container(
     child: Icon(Icons.location_on, size: 50.0, color: Colors.red),
    ),
    ),
     ];

  }



  _updateUserLocationMarker() {
    Marker userLocationMarker = Marker(
      key: ValueKey("userLocation"),
      width: 80.0,
      height: 80.0,
      point: currentLocation,
      child: Container(
        child: Icon(Icons.my_location, size: 50.0, color: Colors.blue),
      ),
    );

    if (markers.any((marker) => marker.key == ValueKey("userLocation"))) {
      int index = markers.indexWhere((marker) => marker.key == ValueKey("userLocation"));
      markers[index] = userLocationMarker;
    } else {
      markers.add(userLocationMarker);
    }
  }

  _locateUser() async {
    var location = Location();
    var userLocation = await location.getLocation();
    print(userLocation.toString());
    setState(() {
      currentLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
    });
  }

  Future<void> _searchAndNavigate() async {
    if (searchController.text.isEmpty) return;
    final query = searchController.text;
    final apiKey = '48b0594741134ba7a54846c836ba8935';
    final url = Uri.parse('https://api.opencagedata.com/geocode/v1/json?q=$query&key=$apiKey');

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        final lat = data['results'][0]['geometry']['lat'];
        final lng = data['results'][0]['geometry']['lng'];
        setState(() {
          currentLocation = LatLng(lat, lng);
          _mapController.move(currentLocation, 15.0);
        });
      }
    }
    catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
         // backgroundColor: Colors.white,
          title: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search for a location...',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: _searchAndNavigate,
              ),
            ),
            onSubmitted: (value) => _searchAndNavigate(),
          ),
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //
        //       Navigator.of(context).pop();
        //     },
        //   ),
        ),
        body: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: currentLocation,
            zoom: 3.0
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            CurrentLocationLayer(),

          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var location = new Location();

            bool serviceEnabled = await location.serviceEnabled();
            if (!serviceEnabled) {
              serviceEnabled = await location.requestService();
              if (!serviceEnabled) {
                return;
              }
            }

            PermissionStatus permissionGranted = await location.hasPermission();
            if (permissionGranted == PermissionStatus.denied) {
              permissionGranted = await location.requestPermission();
              if (permissionGranted != PermissionStatus.granted) {
                return;
              }
            }

            var userLocation = await location.getLocation();
            setState(() {
              currentLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
              _mapController.move(currentLocation, 15.0);
            }
            );
          },
          tooltip: 'Locate Me',
          child: Icon(Icons.my_location),
        ),
      ),
    );
  }
}