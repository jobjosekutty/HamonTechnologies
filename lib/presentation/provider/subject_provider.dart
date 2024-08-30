// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../core/error_handler.dart';
import '../../data/models/subject_model.dart';
import '../../data/repository/subject_repo.dart';


@injectable
class SubjectProvider extends ChangeNotifier {
 final SubjectRepo _subjectRepo;

  SubjectProvider({required SubjectRepo subjectRepo}) : _subjectRepo = subjectRepo;

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

 SubjectModel? subjects;

  Future<void> getSubject() async {
 
      setLoading = true;
       setFailure =null;
    final res = await _subjectRepo.getSubject();
    res.fold((error) {
     
      setFailure = error;
      setLoading = false;
    }, (data) {
      log(data .subjects.toString());
      subjects = data;
      print(subjects?.toJson())
;      notifyListeners();
      setLoading = false;
    });
  }
}
