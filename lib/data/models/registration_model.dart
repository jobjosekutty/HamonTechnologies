// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
    final List<Registration> registrations;

    RegistrationModel({
        required this.registrations,
    });

    factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
        registrations: List<Registration>.from(json["registrations"].map((x) => Registration.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "registrations": List<dynamic>.from(registrations.map((x) => x.toJson())),
    };
}

class Registration {
    final int id;
    final int student;
    final int subject;

    Registration({
        required this.id,
        required this.student,
        required this.subject,
    });

    factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        id: json["id"],
        student: json["student"],
        subject: json["subject"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "student": student,
        "subject": subject,
    };
}
