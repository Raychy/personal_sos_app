// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:personal_sos_app/services/location_service.dart';
import 'package:personal_sos_app/services/preferences/location_preference.dart';
import 'package:personal_sos_app/utils/colors.dart';
import 'package:personal_sos_app/widgets/sos_animated_button.dart';
import 'package:provider/provider.dart';
import '../services/providers/user_provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final LocationService _locationService = LocationService();
  String? lastAddress;
  double? lastLatitude;
  double? lastLongitude;

  @override
  void initState() {
    super.initState();
    _fetchLastLocation();
    _locationService.startLocationUpdates(); // Start background updates
  }
 Future<void> _fetchLastLocation() async {
    await _locationService.ensureLocationSaved(); // Ensure location is saved
    String? address = await LocationStorage().getLastAddress();
    double? latitude = await LocationStorage().getLastLatitude();
    double? longitude = await LocationStorage().getLastLongitude();

    setState(() {
      lastAddress = address ?? "No address available";
      lastLatitude = latitude ?? 0.0;
      lastLongitude = longitude ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    const minHeight = 640;
    final screenHieght = MediaQuery.of(context).size.height;
    final userProvider = Provider.of<UserProvider>(context);
    final username =
        userProvider.username.isNotEmpty ? userProvider.username : "";
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            "Hello, $username",
            style: theme.headlineLarge?.copyWith(
              color: const Color(0xFF191D3E),
            ),
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                color: primaryColor,
              ),
              Text(
                lastAddress ?? 'Fetching location...',
                style: theme.bodyMedium?.copyWith(
                  color: const Color(0xFF191D3E),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHieght > minHeight ? 120 : 80),
        SOSAnimatedButtonWigdget(theme: theme, lastLatitude:lastLatitude, lastLongitude:lastLongitude),
      ],
    );
  }

  @override
  void dispose() {
    _locationService.stopLocationUpdates();
    super.dispose();
  }
}
