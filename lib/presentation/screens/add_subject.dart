// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_constants.dart';
import '../../core/error_handler.dart';
import "package:http/http.dart" as http;

import '../provider/subject_provider.dart';
import '../widgets/snack_bar.dart';
import 'classroom_details.dart';

class AddSubject extends StatelessWidget {
  final int? id;
  const AddSubject({super.key, required this.id});

@override
  Widget build(BuildContext context) {
    return  Scaffold(body: Consumer<SubjectProvider>(
      builder: (context, state, _) {
        
 if (state.homeFailure != null &&
              state.homeFailure is NetworkFailure) {
            return const Center(child: Text("No Internet"));
          }
                   if(state.homeFailure is ServerErrorFailure){
                    
                  WidgetsBinding.instance.addPostFrameCallback((time){
                          scaffoldMessengerKey.currentState?.showSnackBar(
                appSnackBar(
                  "Server Failure  ===>500",
                  Colors.red,
                ),
              );

                  });
            
               

          }
     
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state.subjects != null && state.subjects!.subjects.isNotEmpty) {
           return
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40,),
              SizedBox(height: MediaQuery.of(context).size.height,
                child: ListView.builder(
            
                  itemCount: state.subjects?.subjects.length,
                  itemBuilder: (context, index) {
                    return  Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                         fetch(id,state.subjects!.subjects[index].id,context);
                          
                        },
                        child: Container
                        
                        (height: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.grey[350],),
                        
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.all(10),
                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.subjects?.subjects[index].name??"",style: const TextStyle(fontWeight:FontWeight.bold)),
                                    Text(state.subjects?.subjects[index].teacher??"",style: const TextStyle(fontWeight:FontWeight.bold)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.subjects?.subjects[index].credits.toString()??"",style: const TextStyle(fontWeight:FontWeight.bold)),
                                  const Text("Credit",style: TextStyle(fontWeight:FontWeight.bold))

                                ],
                              )
                            ],
                          )),
                      ),
                    );
                  
                },),
              )
            
          
            ],
          ),
        );
          }
        

        return
         Center(child: Text(state.subjects?.subjects[0].name??"Something went wrong"),);
      }
    ),);
  }
  fetch(int? id, int subjectid,BuildContext context)async{
      Map<String, dynamic>? responseData;
    print("sudentid:$id=====");
        print("subject:$subjectid=====");
        try {
 final Map<String, dynamic> body = {
    'subject': subjectid.toString(),
  };
      final response = await http.patch(Uri.parse('https://nibrahim.pythonanywhere.com/classrooms/$id?api_key=42efb'),body: body);
 print(response.body);
  responseData = json.decode(response.body);
  int studentId = responseData?['id'];
String layout = responseData?['layout'];
String name = responseData?['name'];
int size = responseData?['size'];
int subjectId = responseData?['subject'];
if(response.statusCode ==200){
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => ClassroomDetails(
      name: name,
      layout: layout,
      size: size,
      studentId: studentId,
      subject: subjectId,
    ),
  ),
);

}
    } catch (e) {
    print(e);
    }
  }
}