import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../languages/lang.dart';

class MapPage extends StatefulWidget {
  final Language selectedLanguage;
  MapPage({required this.selectedLanguage});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
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
        point: LatLng(33.3112827, 44.4241059),
        child: Container(
          child: Icon(Icons.location_on, size: 50.0, color: Colors.red),
        ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(33.3101565, 44.4276196),
        child: Container(
          child: Icon(Icons.location_on, size: 50.0, color: Colors.red),
        ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(32.6185146, 44.0812222),
        child: Container(
          child: Icon(Icons.location_on, size: 50.0, color: Colors.red),
        ),
      ),
    ];
  }

  _locateUser() async {
    var location = Location();
    var userLocation = await location.getLocation();
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
    } catch (e) {
      print("Error: $e");
    }
  }

  String getTitle() {
    switch (widget.selectedLanguage) {
      case Language.Arabic:
        return 'خريطة المواقع الطبية';
      case Language.Persian:
        return 'نقشه مکان‌های پزشکی';
      case Language.Kurdish:
        return 'نەخشەی شوێنە پزیشکییەکان';
      case Language.Turkmen:
        return 'Lukmançylyk ýerleriniň kartasy';
      default:
        return 'Medical Locations Map';
    }
  }

  String getSearchHint() {
    switch (widget.selectedLanguage) {
      case Language.Arabic:
        return 'ابحث عن موقع...';
      case Language.Persian:
        return 'جستجوی مکان...';
      case Language.Kurdish:
        return 'گەڕان بۆ شوێنێک...';
      case Language.Turkmen:
        return 'Ýer gözle...';
      default:
        return 'Search for a location...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          getTitle(),
          style: TextStyle(color: Color(0xFF32817D), fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Color(0xFF32817D)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: getSearchHint(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchAndNavigate,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (value) => _searchAndNavigate(),
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: currentLocation,
                zoom: 3.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                CurrentLocationLayer(),
                MarkerLayer(markers: markers),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var location = Location();
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
          });
        },
        tooltip: 'Locate Me',
        backgroundColor: Color(0xFF32817D),
        child: Icon(Icons.my_location),
      ),
    );
  }
}