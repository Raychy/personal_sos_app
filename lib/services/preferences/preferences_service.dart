import 'dart:convert';

import 'package:personal_sos_app/services/model/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _contactsKey = 'sosContacts';
  Future<void> saveUserDetails(
      String matricNo, String username, String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('matricNo', matricNo);
    await prefs.setString('username', username);
    await prefs.setString('language', language);
  }

  Future<Map<String, String>> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'matricNo': prefs.getString('matricNo') ?? '',
      'username': prefs.getString('username') ?? '',
      'language': prefs.getString('language') ?? 'en',
    };
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Contact List

  Future<void> saveContactList(List<ContactModel> contacts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(contacts);
    await prefs.setString(_contactsKey, jsonString);
  }

  Future<List<ContactModel>> getContactList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? contactsString = prefs.getString(_contactsKey);

    if (contactsString == null) return [];
    final List<dynamic> contactList = json.decode(contactsString);
    return contactList.map((c) => ContactModel.fromJson(c)).toList();
  }
}
