import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import '../languages/lang.dart';

class MarkerInfo {
  final LatLng point;
  final String name;
  double distance = 0;

  MarkerInfo({required this.point, required this.name});
}

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
  List<MarkerInfo> markerInfos = [];
  List<Polyline> polylines = [];
  bool isMarkerListVisible = false;

  @override
  void initState() {
    super.initState();
    _locateUser();
    _addMarkers();
  }

  _addMarkers() {
    markerInfos = [
      MarkerInfo(point: LatLng(33.3112827, 44.4241059), name: "Location 1"),
      MarkerInfo(point: LatLng(33.3101565, 44.4276196), name: "Location 2"),
      MarkerInfo(point: LatLng(32.6185146, 44.0812222), name: "Location 3"),
    ];

    markers = markerInfos.map((info) => Marker(
      width: 80.0,
      height: 80.0,
      point: info.point,
      child: Container(
        child: Icon(Icons.location_on_outlined, size: 50.0, color: Colors.red),
      ),
    )).toList();

    _updatePolylines();
  }

  void _calculateDistances() {
    for (var info in markerInfos) {
      info.distance = const Distance().as(LengthUnit.Kilometer, currentLocation, info.point);
    }
    markerInfos.sort((a, b) => a.distance.compareTo(b.distance));
  }

  void _updatePolylines() {
    polylines.clear();
    for (var info in markerInfos) {
      polylines.add(
        Polyline(
          points: [currentLocation, info.point],
          color: Colors.blue.withOpacity(0.7),
          strokeWidth: 3.0,
        ),
      );
    }
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
          _calculateDistances();
          _updatePolylines();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: Text(
          getTitle(),
          style: TextStyle(color: Color(0xFF32817D), fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Color(0xFF32817D)),
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
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
              PolylineLayer(polylines: polylines),
              CurrentLocationLayer(),
              MarkerLayer(markers: markers),
            ],
          ),
          Positioned(
            top: kToolbarHeight + MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: getSearchHint(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _searchAndNavigate,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onSubmitted: (value) => _searchAndNavigate(),
              ),
            ),
          ),
          if (isMarkerListVisible) _buildFloatingMarkerList(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                isMarkerListVisible = !isMarkerListVisible;
              });
            },
            heroTag: 'toggleList',
            child: Icon(isMarkerListVisible ? Icons.list_alt : Icons.list),
            backgroundColor: Color(0xFF32817D),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _locateUser,
            heroTag: 'locateMe',
            child: Icon(Icons.my_location),
            backgroundColor: Color(0xFF32817D),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingMarkerList() {
    _calculateDistances();
    return Positioned(
      top: kToolbarHeight + MediaQuery.of(context).padding.top + 70,
      right: 16,
      child: Container(
        width: 200,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Nearby Locations',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF32817D),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: markerInfos.length,
                itemBuilder: (context, index) {
                  final info = markerInfos[index];
                  return ListTile(
                    title: Text(
                      info.name,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      '${info.distance.toStringAsFixed(2)} km',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    leading: Icon(Icons.location_on, color: Color(0xFF32817D)),
                    onTap: () {
                      _mapController.move(info.point, 15.0);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _locateUser() async {
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
      _calculateDistances();
      _updatePolylines();
    });
  }
}