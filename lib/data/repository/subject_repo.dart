
import 'package:dartz/dartz.dart';
import 'package:hamontest/core/app_url.dart';
import 'package:injectable/injectable.dart';

import "package:http/http.dart" as http;

import '../../core/error_handler.dart';
import '../models/subject_model.dart';


abstract class SubjectRepo {
  Future<Either<Failure, SubjectModel>> getSubject();
}
@LazySingleton(as: SubjectRepo)
class SubjectRepoImpl extends SubjectRepo {
  
  @override
  Future<Either<Failure, SubjectModel>> getSubject() async {
    try {
      final response = await http.get(Uri.parse(AppUrl.subject));
      if (response.statusCode == 200) { 
       final data = subjectModelFromJson(response.body);
      
       return Right(data);
      } else {
        return Left(handleStatusCode(response.statusCode, "error"));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
