// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hamontest/core/app_url.dart';
import 'package:injectable/injectable.dart';

import "package:http/http.dart" as http;

import '../../core/error_handler.dart';
import '../models/registration_model.dart';

abstract class RegistrationRepo {
  Future<Either<Failure, RegistrationModel>>  getRegistration();
  Future<Either<Failure, String>>  registrationDelete(String id,BuildContext context);
}
@LazySingleton(as: RegistrationRepo)
class RegistrationRepoImpl extends RegistrationRepo {
  
  @override
  Future<Either<Failure, RegistrationModel>> getRegistration() async {
    try {
      print("registration......");
      final response = await http.get(Uri.parse(AppUrl.registration));
      if (response.statusCode == 200) { 
       final data = registrationModelFromJson(response.body);
       log(response.body);
      
       return Right(data);
      } else {
        return Left(handleStatusCode(response.statusCode, "error"));
      }
    } catch (e) {
      return Left(handleException(e));
    }
  }
  
  @override
  Future<Either<Failure, String>> registrationDelete(String id,BuildContext context)async {
    print("DELETE!!!");
       try {
     final response = await http.delete(Uri.parse('https://nibrahim.pythonanywhere.com/registration/$id?api_key=42efb'));
     log(response.body);
      
      if (response.statusCode == 200) {
          
        final jsondata = jsonDecode(response.body);
        return Right(jsondata["message"]);
        
        
      } else {
 return Left(handleStatusCode(response.statusCode, "error"));
      }
    } catch (e) {
      return Left(handleException(e));
    }
    
  }
}
