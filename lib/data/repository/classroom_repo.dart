// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import "package:http/http.dart" as http;

import '../../core/error_handler.dart';
import '../models/classroom_model.dart';

abstract class ClassroomRepo {
  Future<Either<Failure, ClassroomModel>>  getClassroom();
}
@LazySingleton(as: ClassroomRepo)
class ClassroomRepoImpl extends ClassroomRepo {
  
  @override
  Future<Either<Failure, ClassroomModel>> getClassroom() async {
    try {
      print("testing......");
     // final url = Uri.https.;
      final response = await http.get(Uri.parse('https://nibrahim.pythonanywhere.com/classrooms/?api_key=42efb'));
      if (response.statusCode == 200) { 
       final data = classroomModelFromJson(response.body);
       print("CLASSROOMS");
       log(response.body);
      
       return Right(data);
      } else {
        return Left(handleStatusCode(response.statusCode, "error"));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
