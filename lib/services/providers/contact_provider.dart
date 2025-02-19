import 'package:flutter/material.dart';
import 'package:personal_sos_app/services/model/contact_model.dart';
import 'package:personal_sos_app/services/preferences/preferences_service.dart';
import 'package:uuid/uuid.dart';

class ContactProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool _isSaving = false;
  List<ContactModel> _sosContacts = [];
  String _successMessage = '';
  String _failedMessage = '';

  String get successMessage => _successMessage;
  String get failedMessage => _failedMessage;
  List<ContactModel> get sosContacts => _sosContacts;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;

  final PreferencesService _preferencesService = PreferencesService();

  Future<void> loadContactList() async {
    _isLoading = true;
    notifyListeners();
    try {
      _sosContacts = await _preferencesService.getContactList();
      _isLoading = false;
      notifyListeners();
    } catch (err) {
      _isLoading = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> storeContactList(
      String firstName, String lastName, String phoneNumber) async {
    try {
      _isSaving = true;
      notifyListeners();

      // Check if the contact already exists
      await loadContactList();
      bool contactExists =
          _sosContacts.any((element) => element.phoneNumber == phoneNumber);

      if (contactExists) {
        _failedMessage = '+234$phoneNumber already exists';
        notifyListeners();
      } else {
        final newContact = ContactModel(
            id: const Uuid().v4(),
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            dateTime: DateTime.now());
        _sosContacts.add(newContact);

        await _preferencesService.saveContactList(_sosContacts);
        _successMessage = 'Contact saved successfully';
      }
    } catch (err) {
      _failedMessage = 'Failed to add contact';
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<void> updateContact(
      String id, String firstName, String lastName, String phoneNumber) async {
    try {
      _isSaving = true;
      notifyListeners();
      final index = _sosContacts.indexWhere((c) => c.id == id);
      if (index != -1) {
        _sosContacts[index] = ContactModel(
            id: id,
            firstName: firstName,
            phoneNumber: phoneNumber,
            dateTime: _sosContacts[index].dateTime,
            lastName: lastName);
        await _preferencesService.saveContactList(_sosContacts);
        _successMessage = 'Contact upodated successfully';
        await loadContactList();
        notifyListeners();
      }
    } catch (err) {
      _failedMessage = 'Failed to update contact';
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<void> deleteContact(String id) async {
    _sosContacts.removeWhere((c) => c.id == id);
    await _preferencesService.saveContactList(_sosContacts);
    await loadContactList();
  }
}
