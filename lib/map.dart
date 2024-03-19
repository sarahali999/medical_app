import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MapController _mapController = MapController();
  var currentLocation = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _locateUser();
  }

  _locateUser() async {
    var location = Location();
    var userLocation = await location.getLocation();
    setState(() {
      currentLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Location Map'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to the previous page
              // This will work if your current page was pushed onto the navigation stack
              Navigator.of(context).pop();
            },
          ),
        ),

        body: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
              center: new LatLng(32.6076326,44.093935),
              zoom: 10.0
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: new LatLng(32.6206034,44.0526547),
                  child: Icon(Icons.location_on, size: 50.0, color: Colors.red),

                ),
              ],

            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: new LatLng(32.6003987,44.0272621),
                  child: Icon(Icons.location_on, size: 50.0, color: Colors.red),

                ),
              ],

            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: new LatLng(32.595453,44.0210427),
                  child: Icon(Icons.location_on, size: 50.0, color: Colors.red),

                ),
              ],

            ),


          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var location = Location();

            var serviceEnabled = await location.serviceEnabled();
            if (!serviceEnabled) {
              serviceEnabled = await location.requestService();
              if (!serviceEnabled) {
                return;
              }
            }

            var permissionGranted = await location.hasPermission();
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
            });
          },
          tooltip: 'Locate Me',
          child: Icon(Icons.my_location),
        ),

      ),
    );
  }
}