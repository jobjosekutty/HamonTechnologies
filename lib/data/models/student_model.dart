// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) => StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
    final List<Student> students;

    StudentModel({
        required this.students,
    });

    factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        students: List<Student>.from(json["students"].map((x) => Student.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "students": List<dynamic>.from(students.map((x) => x.toJson())),
    };
}

class Student {
    final int age;
    final String email;
    final int id;
    final String name;

    Student({
        required this.age,
        required this.email,
        required this.id,
        required this.name,
    });

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        age: json["age"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "age": age,
        "email": email,
        "id": id,
        "name": name,
    };
}
