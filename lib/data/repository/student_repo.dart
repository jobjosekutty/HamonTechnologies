
import 'package:dartz/dartz.dart';
import 'package:hamontest/core/app_url.dart';
import 'package:injectable/injectable.dart';

import "package:http/http.dart" as http;

import '../../core/error_handler.dart';
import '../models/student_model.dart';

abstract class StudentRepo {
  Future<Either<Failure, StudentModel>> getStudent();
}
@LazySingleton(as: StudentRepo)
class StudentRepoImpl extends StudentRepo {
  
  @override
  Future<Either<Failure, StudentModel>> getStudent() async {
    try {
      final response = await http.get(Uri.parse(AppUrl.student));
      if (response.statusCode == 200) { 
       final data = studentModelFromJson(response.body);
      
       return Right(data);
      } else {
        return Left(handleStatusCode(response.statusCode, "error"));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
