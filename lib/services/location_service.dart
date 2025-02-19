// ignore_for_file: avoid_print

import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:personal_sos_app/services/preferences/location_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  Timer? _timer;

  /// Get current location (latitude & longitude)
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        return null;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print('Location permissions are denied.');
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('Error fetching location: $e');
      return null;
    }
  }

  /// Convert latitude & longitude to street and city
  Future<String?> getAddressFromPosition(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.street}, ${place.locality}";
      }
    } catch (e) {
      print('Error fetching address: $e');
    }
    return null;
  }

  /// Save location data in SharedPreferences
  Future<void> saveLocationData(Position position, String? address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', position.latitude);
    await prefs.setDouble('longitude', position.longitude);
    await prefs.setString('address', address ?? "Unknown Location");
  }

  /// Fetch and save location if not saved yet
  Future<void> ensureLocationSaved() async {
    String? lastAddress = await LocationStorage().getLastAddress();
    double? lastLatitude = await LocationStorage().getLastLatitude();
    double? lastLongitude = await LocationStorage().getLastLongitude();

    if (lastAddress == null || lastLatitude == null || lastLongitude == null) {
      print("No location saved. Fetching...");
      await updateLocation();
    } else {
      print(
          "Location already saved: $lastAddress ($lastLatitude, $lastLongitude)");
    }
  }

  /// Fetch current location, get street/city, and store in SharedPreferences
  Future<void> updateLocation() async {
    Position? position = await getCurrentLocation();
    if (position != null) {
      String? address = await getAddressFromPosition(position);
      await saveLocationData(position, address);
      print(
          "Updated location: $address (${position.latitude}, ${position.longitude})");
    }
  }

  /// Start updating location every 30 minutes
  void startLocationUpdates() {
    _timer = Timer.periodic(const Duration(minutes: 30), (timer) async {
      await updateLocation();
    });
  }

  /// Stop location updates
  void stopLocationUpdates() {
    _timer?.cancel();
  }
}
