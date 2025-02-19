import 'package:shared_preferences/shared_preferences.dart';

class LocationStorage {
  /// Get last saved latitude
  Future<double?> getLastLatitude() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('latitude');
  }

  /// Get last saved longitude
  Future<double?> getLastLongitude() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('longitude');
  }

  /// Get last saved address
  Future<String?> getLastAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('address');
  }
}
