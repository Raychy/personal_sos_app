// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_sos_app/services/model/contact_model.dart';

class SMSProvider extends ChangeNotifier {
  static const platform = MethodChannel('sendSms');
  String _successMessage = '';
  String _failedMessage = '';
  String get successMessage => _successMessage;
  String get failedMessage => _failedMessage;

  Future<void> sendEmergencySms(List<ContactModel> phoneNumbers, String message) async {
    try {
      var smsPermission = Permission.sms;

      // Request SMS permission if not granted
      if (await smsPermission.isDenied || await smsPermission.isPermanentlyDenied) {
        await smsPermission.request();
      }

      if (!await smsPermission.isGranted) {
        _failedMessage = "SMS permission denied!";
        notifyListeners();
        return;
      }

      // Send SMS to each contact
      for (var phone in phoneNumbers) {
        try {
        await platform.invokeMethod(
            'send',
            <String, dynamic>{"phone": "+234${phone.phoneNumber}", "msg": message},
          );
          // print("sent====${phone.phoneNumber}");
        } catch (e) {
          print("Failed to send SMS to $phone: $e");
        }
      }

      _successMessage = "Emergency SMS sent to ${phoneNumbers.length} contacts!";
      notifyListeners();
    } on PlatformException catch (e) {
      _failedMessage = "Failed to send SMS: ${e.message}";
      notifyListeners();
    }
  }
 
}
