
class ContactModel {
  String id;
  String firstName;
  String lastName;
  String phoneNumber;
  DateTime dateTime;

  ContactModel({
    required this.id,
    required this.firstName,
    required this.phoneNumber,
    required this.dateTime,
    required this.lastName,
  });

  // Convert ContactModel to JSON
  Map<String, String> toJson() => {
        'id': id,
        'firstName': firstName,
        'phoneNumber': phoneNumber,
        'lastName': lastName,
        'dateTime': dateTime.toIso8601String(), // Convert DateTime to String
      };

  // Convert JSON to ContactModel
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] ??  "",
      firstName: json['firstName']  ??  "",
      phoneNumber: json['phoneNumber']  ??  "",
      lastName: json['lastName']  ??  "",
      dateTime: DateTime.parse(json['dateTime']), // Parse String to DateTime
    );
  }
}
