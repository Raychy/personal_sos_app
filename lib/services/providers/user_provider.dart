import 'package:flutter/material.dart';
import 'package:personal_sos_app/services/preferences/preferences_service.dart';

class UserProvider extends ChangeNotifier {
  String _matricNo = '';
  String _username = '';
  String _language = 'en';
  bool _isLoading = true;

  String get matricNo => _matricNo;
  String get username => _username;
  String get language => _language;
  bool get isLoading => _isLoading;

  final PreferencesService _preferencesService = PreferencesService();

  Future<void> loadUserDetails() async {
    _isLoading = true;
    notifyListeners();

    final details = await _preferencesService.getUserDetails();
    _matricNo = details['matricNo']!;
    _username = details['username']!;
    _language = details['language']!;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> storeUserDetails(String matricNo, String username, String language) async {
    _matricNo = matricNo;
    _username = username;
    _language = language;
    await _preferencesService.saveUserDetails(matricNo, username, language);
    notifyListeners();
  }



}
