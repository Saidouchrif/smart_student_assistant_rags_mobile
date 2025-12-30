import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Position? userPosition;
  double? distanceKm;

  // 📍 Coordinates ديال المدرسة (Université Mundiapolis – Nouaceur)
  final LatLng schoolLocation = const LatLng(33.3676, -7.5876);

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final meters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      schoolLocation.latitude,
      schoolLocation.longitude,
    );

    setState(() {
      userPosition = position;
      distanceKm = meters / 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userPosition == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Localisation'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                userPosition!.latitude,
                userPosition!.longitude,
              ),
              initialZoom: 13,
            ),
            children: [
              // 🌍 OpenStreetMap Tiles
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName:
                    'com.example.smart_student_assistant',
              ),

              // 🔵 Line between user & school
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      LatLng(
                        userPosition!.latitude,
                        userPosition!.longitude,
                      ),
                      schoolLocation,
                    ],
                    strokeWidth: 4,
                    color: Colors.blue,
                  ),
                ],
              ),

              // 📍 Markers
              MarkerLayer(
                markers: [
                  // User marker
                  Marker(
                    point: LatLng(
                      userPosition!.latitude,
                      userPosition!.longitude,
                    ),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),

                  // School marker
                  Marker(
                    point: schoolLocation,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.school,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 📏 Distance Card
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '📍 Distance jusqu’à la faculté : ${distanceKm!.toStringAsFixed(2)} km',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
