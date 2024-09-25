import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:lottie/lottie.dart';
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
  final flutter_map.MapController _mapController = flutter_map.MapController();
  LatLng currentLocation = LatLng(0, 0);
  TextEditingController searchController = TextEditingController();
  List<flutter_map.Marker> markers = [];
  List<MarkerInfo> markerInfos = [];
  List<flutter_map.Polyline> polylines = [];
  bool isMarkerListVisible = false;
  MarkerInfo? selectedMarker;

  @override
  void initState() {
    super.initState();
    _locateUser();
    _fetchMarkersFromApi();
  }

  Future<void> _fetchMarkersFromApi() async {
    final url = Uri.parse('http://medicalpoint-api.tatwer.tech/api/Mobile/CenterMap');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        markerInfos = data.map((json) {
          final lat = json['lot'];
          final lng = json['lag'];
          final name = json['centerName'];
          return MarkerInfo(
            point: LatLng(lat, lng),
            name: name,
          );
        }).toList();

        _calculateDistances();

        setState(() {
          markers = markerInfos.map((info) => flutter_map.Marker(
            width: 50.0,
            height: 50.0,
            point: info.point,
            child: GestureDetector(
              onTap: () => _selectMarker(info),
              child: Stack(
                children: [
                  Lottie.asset('assets/lottie/mark.json'),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      color: Colors.white.withOpacity(0.7),
                      child: Text(
                        '${info.distance.toStringAsFixed(2)} km',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )).toList();
          _updatePolylines();
        });
      } else {
        print("Failed to load markers. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching markers: $e");
    }
  }

  void _selectMarker(MarkerInfo info) {
    setState(() {
      selectedMarker = info;
      _updatePolylines();
      isMarkerListVisible = false;
      _mapController.move(info.point, 15.0);
    });
  }

  void _calculateDistances() {
    for (var info in markerInfos) {
      info.distance = const Distance().as(LengthUnit.Kilometer, currentLocation, info.point);
    }
    markerInfos.sort((a, b) => a.distance.compareTo(b.distance));
  }

  void _updatePolylines() {
    polylines.clear();
    if (selectedMarker != null) {
      polylines.add(
        flutter_map.Polyline(
          points: [currentLocation, selectedMarker!.point],
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

  String _getFormattedDistance() {
    if (selectedMarker == null) return '';
    double distance = const Distance().as(LengthUnit.Kilometer, currentLocation, selectedMarker!.point);
    return '${distance.toStringAsFixed(2)} km';
  }

  void _clearSelection() {
    setState(() {
      selectedMarker = null;
      _updatePolylines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _isRtlLanguage(widget.selectedLanguage)
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
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
                initialCenter: currentLocation,
                initialZoom: 3.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c', 'd'],
                ),
                PolylineLayer(polylines: polylines),
                CurrentLocationLayer(),
                MarkerLayer(markers: markers),
              ],
            ),
            _buildSearchBar(),
            if (isMarkerListVisible) _buildFloatingMarkerList(),
            if (selectedMarker != null) _buildSelectedMarkerInfo(),
          ],
        ),
        floatingActionButton: _buildFloatingActionButtons(),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Positioned(
      top: kToolbarHeight + MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
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
    );
  }

  Widget _buildFloatingMarkerList() {
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
                    onTap: () => _selectMarker(info),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedMarkerInfo() {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedMarker!.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Distance: ${_getFormattedDistance()}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (selectedMarker != null)
          FloatingActionButton(
            onPressed: _clearSelection,
            heroTag: 'clearSelection',
            child: Icon(Icons.clear, color: Color(0xFF32817D)),
            backgroundColor: Colors.white.withOpacity(0.8),
          ),
        SizedBox(height: 16),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              isMarkerListVisible = !isMarkerListVisible;
            });
          },
          heroTag: 'toggleList',
          child: Icon(isMarkerListVisible ? Icons.list_alt :
          Icons.list,
              color: Color(0xFF32817D)),
          backgroundColor: Colors.white.withOpacity(0.8),
        ),
        SizedBox(height: 16),
        FloatingActionButton(
          onPressed: _locateUser,
          heroTag: 'locateMe',
          child: Icon(Icons.my_location, color: Color(0xFF32817D)),
          backgroundColor: Colors.white.withOpacity(0.8),
        ),
      ],
    );
  }
  void _locateUser() async {
    try {
      var location = Location();
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          print("Location services are disabled.");
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          print("Location permission not granted.");
          return;
        }
      }

      var userLocation = await location.getLocation();
      print("User location: ${userLocation.latitude}, ${userLocation.longitude}");

      setState(() {
        currentLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
        _mapController.move(currentLocation, 15.0);
        _calculateDistances();
        _updatePolylines();
      });

      print("Map moved to: ${currentLocation.latitude}, ${currentLocation.longitude}");
    } catch (e) {
      print("Error in _locateUser: $e");
    }
  }

  bool _isRtlLanguage(Language language) {
    return language == Language.Arabic || language == Language.Persian || language == Language.Kurdish;
  }
}