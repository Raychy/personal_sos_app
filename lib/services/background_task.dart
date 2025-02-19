// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:personal_sos_app/services/location_service.dart';
import 'package:personal_sos_app/services/model/contact_model.dart';
import 'package:personal_sos_app/services/preferences/location_preference.dart';
import 'package:personal_sos_app/services/preferences/preferences_service.dart';
import 'package:personal_sos_app/services/providers/sms_provider.dart';
import 'package:workmanager/workmanager.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("🔄 started...$task");
    if (task == "Listen for emergency words") {
      print("🔄 Background listening started...");

      stt.SpeechToText speech = stt.SpeechToText();
      bool available = await speech.initialize();
      if (!available) return Future.value(true);

      await speech.listen(onResult: (result) async {
        String command = result.recognizedWords.toLowerCase();
        print("🎤 Detected: $command");

        if (command.contains("sos") ||
            command.contains("help") ||
            command.contains("emergency")) {
          print("🚨 Emergency detected! Launching app...");

          try {
            const MethodChannel platform = MethodChannel('background_service');
            await platform.invokeMethod('launchApp');
          } on PlatformException catch (e) {
            print("❌ Error launching app: $e");

            const intent = AndroidIntent(
              action: "android.intent.action.MAIN",
              package: "com.example.personal_sos_app",
              componentName: "com.example.personal_sos_app.MainActivity",
            );
            await intent.launch();
          }
        }
      });

      await Future.delayed(const Duration(seconds: 5));
      await speech.stop();
    }
    return Future.value(true);
  });
}

class BackgroundVoiceCommandProvider with ChangeNotifier {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  bool get isListening => _isListening;

  /// Initializes WorkManager for background listening
  Future<void> initVoiceListening() async {
    Workmanager().initialize(callbackDispatcher,
        isInDebugMode: true); // ✅ Use the correct function
    Workmanager().registerPeriodicTask(
      "emergency_listener",
      "Listen for emergency words",
      frequency: const Duration(minutes: 15),
    );
  }

  /// Listens for emergency words like "SOS" or "Help"
  Future<void> listenForEmergencyWords() async {
    bool available = await _speech.initialize();
    if (!available) return;

    _isListening = true;
    notifyListeners();

    await _speech.listen(onResult: (result) {
      String command = result.recognizedWords.toLowerCase();
      print("🎤 Detected: $command");

      if (command.contains("sos") ||
          command.contains("help") ||
          command.contains("emergency")) {
        print("🚨 Emergency detected! Launching app and sending SOS...");
        _launchApp();
        _sendEmergencySms();
      }
    });

    await Future.delayed(const Duration(seconds: 5));
    await _speech.stop();
    _isListening = false;
    notifyListeners();
  }

  /// Launches the app when an emergency is detected
  void _launchApp() async {
    const MethodChannel platform = MethodChannel('background_service');
    try {
      await platform.invokeMethod('launchApp');
    } on PlatformException catch (e) {
      print("❌ Error launching app: $e");

      // Alternative: Open app using Android Intent
      const intent = AndroidIntent(
        action: "android.intent.action.MAIN",
        package: "com.example.personal_sos_app",
        componentName: "com.example.personal_sos_app.MainActivity",
      );
      await intent.launch();
    }
  }

  /// Sends an emergency SMS
  void _sendEmergencySms() async {
    try {
      await PreferencesService().getContactList();
      await LocationService().getCurrentLocation();
      await LocationService().ensureLocationSaved();
      double? lastLatitude = await LocationStorage().getLastLatitude();
      double? lastLongitude = await LocationStorage().getLastLongitude();
      final userDetail = await PreferencesService().getUserDetails();
      List<ContactModel> emergencyContacts =
          await PreferencesService().getContactList();
      String matricNo = userDetail['matricNo'] ?? "";

      String locationUrl =
          "https://www.google.com/maps/search/?api=1&query=$lastLatitude,$lastLongitude";
      String emergencyMessage =
          "HELP ME ($matricNo) IT'S AN EMERGENCY!! Please reach out ASAP to the location below\nLocation: $locationUrl";

      SMSProvider smsProvider = SMSProvider();
      await smsProvider.sendEmergencySms(emergencyContacts, emergencyMessage);
    } catch (e) {
      print("❌ Error sending emergency SMS: $e");
    }
  }
}
