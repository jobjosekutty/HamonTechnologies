// ignore_for_file: avoid_print, prefer_const_declarations, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../core/app_color.dart';
import '../../core/app_constants.dart';
import '../../di/get_it.dart';
import '../provider/registration_provider.dart';
import '../provider/student_provider.dart';
import '../provider/subject_provider.dart';
import '../widgets/common_app_bar.dart';
import "package:http/http.dart" as http;

import '../widgets/snack_bar.dart';
import 'registration.dart';
import 'student_selection.dart';
import 'subject_selection.dart';


class NewRegistrationScreen extends StatefulWidget {
   // ignore: prefer_const_constructors_in_immutables
   NewRegistrationScreen({super.key, this.subject, this.student, this.subjectid, this.studentid});

  final String? subject;
  final String? student;
  final int? studentid;
  final int? subjectid;

  @override
  State<NewRegistrationScreen> createState() => _NewRegistrationScreenState();
}

class _NewRegistrationScreenState extends State<NewRegistrationScreen> {
  @override
  void initState() {
    print(widget.studentid);
    data();
    get();
  
    super.initState();
  }
  String? stu;
  String? sub;
  int? stuid;
  int? subid;
  data()async{
     final SharedPreferences preferences = await SharedPreferences.getInstance();
           preferences.setString("student",widget.student!);
            preferences.setString("subject",widget.subject!);
            

  }
  get()async{
      final SharedPreferences preferences = await SharedPreferences.getInstance();
    
            stu = preferences.getString("student");
            print("====getstudent==$stu");
            
    sub=        preferences.getString("subject");
     print("====getsubject==$sub");
      stuid=        preferences.getInt("studentid");
        print("====getsubject==$stuid");
       subid=        preferences.getInt("subjectid");
         print("====getsubject==$subid");
     setState(() {
       
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:loading?const Center(child: CircularProgressIndicator(),): CustomScrollView(
        slivers: [
          const CommonAppbar(title: 'New Registration'),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
              ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        tileColor: AppColors.tileColor,
                        title:widget.student!=null?Text(widget.student.toString()):stu!=null?Text(stu.toString()): const Text(
                         
                              'Select a Student'
                         
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                             Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                    create: (context) => getIt<StudentProvider>()..getStudent(),
                                    child: const StudentSelection(),
                                  )),
                        );
                        },
                      ),
                  setHeight(16),
             ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        tileColor: AppColors.tileColor,
                        title:widget.subject!=null?Text(widget.subject.toString()):sub!=null?Text(sub.toString()): const Text(
                        
                              'Select a Subject'
                           
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                             Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                    create: (context) => getIt< SubjectProvider>()..getSubject(),
                                    child: const SubjectSelection(),
                                
                                  )),
                        );
                        },
                      ),
                  setHeight(32),
               ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          createRegistration(stuid,subid,context);
                        },
                        child: const Text('Register'),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
 bool loading = false;
  Future<void> createRegistration(int? studentId, int? subjectId,BuildContext context) async {
    loading = true;
    setState(() {
      
    });
    print(stuid);
    print(subid);
  final String url = 'https://nibrahim.pythonanywhere.com/registration/?api_key=42efb';

  final response = await http.post(
    Uri.parse(url),
    body: {
      'student': studentId.toString(),
      'subject': subjectId.toString(),
    },
  );
log(response.body);
  if (response.statusCode == 200) {
      loading = false;
    setState(() {
      
    });
    final responseBody = jsonDecode(response.body);
    print('Response ID: ${responseBody['id']}');
    print('Student ID: ${responseBody['student']}');
    print('Subject ID: ${responseBody['subject']}');
              scaffoldMessengerKey.currentState?.showSnackBar(
                      
                appSnackBar(
                  "Registration Successfully Done",
                  Colors.green,
                ),
              );
           Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                    create: (context) => getIt<RegistrationProvider>()..getRegistartion(),
                                    child: const RegistrationsScreen(),
                                  )),
                        );

  } else {
    print('Failed to create registration. Status code: ${response.statusCode}');
  }
}
}
