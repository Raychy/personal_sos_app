// To parse this JSON data, do
//
//     final emergencyModel = emergencyModelFromJson(jsonString);

import 'dart:convert';

EmergencyModel emergencyModelFromJson(String str) => EmergencyModel.fromJson(json.decode(str));

String emergencyModelToJson(EmergencyModel data) => json.encode(data.toJson());

class EmergencyModel {
    String university;
    List<EmergencySosTip> emergencySosTips;

    EmergencyModel({
        required this.university,
        required this.emergencySosTips,
    });

    factory EmergencyModel.fromJson(Map<String, dynamic> json) => EmergencyModel(
        university: json["university"],
        emergencySosTips: List<EmergencySosTip>.from(json["emergency_sos_tips"].map((x) => EmergencySosTip.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "university": university,
        "emergency_sos_tips": List<dynamic>.from(emergencySosTips.map((x) => x.toJson())),
    };
}

class EmergencySosTip {
    String title;
    List<String>? tips;
    Details? details;

    EmergencySosTip({
        required this.title,
        this.tips,
        this.details,
    });

    factory EmergencySosTip.fromJson(Map<String, dynamic> json) => EmergencySosTip(
        title: json["title"],
        tips: json["tips"] == null ? [] : List<String>.from(json["tips"]!.map((x) => x)),
        details: json["details"] == null ? null : Details.fromJson(json["details"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "tips": tips == null ? [] : List<dynamic>.from(tips!.map((x) => x)),
        "details": details?.toJson(),
    };
}

class Details {
    String campusSecurity;
    String medicalCenter;
    String fireDepartment;
    String studentAffairs;

    Details({
        required this.campusSecurity,
        required this.medicalCenter,
        required this.fireDepartment,
        required this.studentAffairs,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        campusSecurity: json["campus_security"],
        medicalCenter: json["medical_center"],
        fireDepartment: json["fire_department"],
        studentAffairs: json["student_affairs"],
    );

    Map<String, dynamic> toJson() => {
        "campus_security": campusSecurity,
        "medical_center": medicalCenter,
        "fire_department": fireDepartment,
        "student_affairs": studentAffairs,
    };
}
