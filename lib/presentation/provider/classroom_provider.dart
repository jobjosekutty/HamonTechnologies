
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../core/error_handler.dart';
import '../../data/models/classroom_model.dart';
import '../../data/repository/classroom_repo.dart';



@injectable
class ClassroomProvider extends ChangeNotifier {
 final ClassroomRepo _classroomRepo;

  ClassroomProvider({required ClassroomRepo classroomRepo}) : _classroomRepo = classroomRepo;

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

ClassroomModel? classroom;

  Future<void> getClassroom() async {
 
      setLoading = true;
       setFailure =null;
    final res = await _classroomRepo.getClassroom();
    res.fold((error) {
     
      setFailure = error;
      setLoading = false;
    }, (data) {
    ///  log(data.classrooms.toString());
     classroom = data;
    //  print(students?.toJson())
      notifyListeners();
      setLoading = false;
    });
  }
}
