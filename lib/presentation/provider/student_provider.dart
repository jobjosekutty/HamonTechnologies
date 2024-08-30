// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../core/error_handler.dart';
import '../../data/models/student_model.dart';
import '../../data/repository/student_repo.dart';


@injectable
class StudentProvider extends ChangeNotifier {
 final StudentRepo _studentRepo;

  StudentProvider({required StudentRepo studentRepo}) : _studentRepo = studentRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Failure? _failure;

  Failure? get homeFailure => _failure;
  set setFailure(Failure? value) {
    _failure = value;
    notifyListeners();
  }

 StudentModel? students;

  Future<void> getStudent() async {
 
      setLoading = true;
       setFailure =null;
    final res = await _studentRepo.getStudent();
    res.fold((error) {
     
      setFailure = error;
      setLoading = false;
    }, (data) {
      log(data.students.toString());
      students = data;
      print(students?.toJson())
;      notifyListeners();
      setLoading = false;
    });
  }
}
