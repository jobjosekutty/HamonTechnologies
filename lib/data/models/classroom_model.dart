// To parse this JSON data, do
//
//     final classroomModel = classroomModelFromJson(jsonString);

import 'dart:convert';

ClassroomModel classroomModelFromJson(String str) => ClassroomModel.fromJson(json.decode(str));

String classroomModelToJson(ClassroomModel data) => json.encode(data.toJson());

class ClassroomModel {
    final List<Classroom> classrooms;

    ClassroomModel({
        required this.classrooms,
    });

    factory ClassroomModel.fromJson(Map<String, dynamic> json) => ClassroomModel(
        classrooms: List<Classroom>.from(json["classrooms"].map((x) => Classroom.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "classrooms": List<dynamic>.from(classrooms.map((x) => x.toJson())),
    };
}

class Classroom {
    final int id;
    final String layout;
    final String name;
    final int size;

    Classroom({
        required this.id,
        required this.layout,
        required this.name,
        required this.size,
    });

    factory Classroom.fromJson(Map<String, dynamic> json) => Classroom(
        id: json["id"],
        layout: json["layout"],
        name: json["name"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "layout": layout,
        "name": name,
        "size": size,
    };
}
