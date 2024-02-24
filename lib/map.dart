import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'الخريطة',

      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? currentPosition;
  Position? previousPosition;
  List<GeoPoint> selectedPoints = [];
  List<SearchInfo> currentSuggestions = [];

  String formattedDistance = "";
  String formattedDuration = "00";
  String formattedSpeed = "0.00";

  double speed = 0;

  final controller = MapController.withUserPosition(
    trackUserLocation: UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
  );

  MarkerIcon iconic = MarkerIcon(
    icon: Icon(
      Icons.location_pin,
      color: Colors.red,
      size: 60,
    ),
  );

  MarkerIcon iconicTrajetForSpeed = MarkerIcon(
    icon: Icon(
      Icons.location_pin,
      color: Colors.blue,
      size: 60,
    ),
  );

  double? distance = 0.0;
  double? duration = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      checkAndRequestLocationPermission();
      initializeMap();
      GeoPoint lomeGeoPoint = GeoPoint(
          latitude: 33.3136516, longitude: 44.5022817);
      printLocationName(lomeGeoPoint);
    });
  }

  Future<void> checkAndRequestLocationPermission() async {
    if (await Permission.location.isGranted) {
      print('Location permission granted');
      return;
    }

    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      print('Location permission granted');
      return;
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (mounted) {
      setState(() {
        currentPosition = position;
        controller.setZoom(zoomLevel: 17.5);
        controller.changeLocation(
          GeoPoint(latitude: position.latitude, longitude: position.longitude),
        );
      });
    }
  }

  Future<void> GotoMyLocalisation() async {
    await controller.enableTracking(enableStopFollow: false);

    await Future.delayed(Duration(seconds: 3));

    GeoPoint userLocation = await controller.myLocation();
    double latitude = userLocation.latitude;
    double longitude = userLocation.longitude;
    print('User Location: Latitude $latitude, Longitude $longitude');

    if (mounted) {
      setState(() {
        controller.setZoom(zoomLevel: 18.5);
        controller.changeLocation(
            GeoPoint(latitude: userLocation.latitude,
                longitude: userLocation.longitude));
      });
    }
  }


  Future<String> getLocationName(GeoPoint location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,

      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;

        String name = placemark.name ?? '';
        String locality = placemark.locality ?? '';
        String sublocality = placemark.subLocality ?? '';
        String Subadministrative = placemark.subAdministrativeArea ?? '';
        String Country = placemark.country ?? '';

        String completeLocationName =
            ' $name, $Subadministrative, $locality - $Country';

        return completeLocationName ?? '';
      } else {
        return 'Aucun emplacement trouvé.';
      }
    } catch (e) {
      return 'Erreur lors de la recherche de l\'emplacement : $e';
    }
  }

  Future<void> printLocationName(GeoPoint location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
        localeIdentifier: 'fr',
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;

        String name = placemark.name ?? '';
        String locality = placemark.locality ?? '';
        String sublocality = placemark.subLocality ?? '';
        String Subadministrative = placemark.subAdministrativeArea ?? '';
        String Country = placemark.country ?? '';

        String completeLocationName =
            ' $name, $Subadministrative, $locality, $Country';

        print('Geocoding Result: $placemark');
        print('Complete Location Name: $completeLocationName');
      } else {
        print('Aucun emplacement trouvé.');
      }
    } catch (e) {
      print('Erreur lors de la recherche de l\'emplacement : $e');
    }
  }


  Future<void> initializeMap() async {
    await Future.delayed(Duration(seconds: 4));

    await controller.enableTracking(enableStopFollow: false);

    await Future.delayed(Duration(seconds: 3));

    GeoPoint userLocation = await controller.myLocation();
    double latitude = userLocation.latitude;
    double longitude = userLocation.longitude;
    print('User Location: Latitude $latitude, Longitude $longitude');

    if (mounted) {
      setState(() {
        controller.setZoom(zoomLevel: 17.5);
        controller.changeLocation(
            GeoPoint(latitude: userLocation.latitude,
                longitude: userLocation.longitude));
      });
    }
  }

  Future<void> showLocationNameDialog(String locationName) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Name'),
          content: Text(locationName),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 750,
              child: controller != null
                  ? OSMFlutter(
                controller: controller,
                osmOption: OSMOption(
                  markerOption: MarkerOption(
                    defaultMarker: MarkerIcon(
                      icon: Icon(
                        Icons.person_pin_circle,
                        color: Colors.red,
                        size: 60,
                      ),
                    ),
                  ),
                ),
              )
                  : CircularProgressIndicator(),
            ),
            SizedBox(height: 18),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              GotoMyLocalisation();
            },
            tooltip: 'Zoom to My Location',
            child: Icon(Icons.gps_fixed),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () async {
              GeoPoint userLocation = await controller.myLocation();
              String locationName = await getLocationName(userLocation);
              showLocationNameDialog(locationName);
            },
            tooltip: 'Get Location Name',
            child: Icon(Icons.location_on),
          ),
        ],
      ),
    );
  }
}