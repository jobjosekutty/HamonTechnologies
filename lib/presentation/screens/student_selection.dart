// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../core/app_constants.dart';
import '../../core/error_handler.dart';
import '../provider/student_provider.dart';
import '../widgets/snack_bar.dart';
import 'new_registraion.dart';

class StudentSelection extends StatelessWidget {
  const StudentSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Students"),centerTitle: true,),
      body: Consumer<StudentProvider>(
      builder: (context, state, _) {
        
 if (state.homeFailure != null &&
              state.homeFailure is NetworkFailure) {
            return const Center(child: Text("No Internet"));
          }

          if(state.homeFailure is ServerFailure){
            
                     scaffoldMessengerKey.currentState?.showSnackBar(
                appSnackBar(
                  "Server Failure",
                  Colors.red,
                ),
              );

          }
              if(state.homeFailure is ServerErrorFailure){
            
                     scaffoldMessengerKey.currentState?.showSnackBar(
                appSnackBar(
                  "Server Failure  ===>500",
                  Colors.red,
                ),
              );

          }
     
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state.students != null && state.students!.students.isNotEmpty) {
           return
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
               // SizedBox(height: 40,),
                SizedBox(height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
              
                    itemCount: state.students?.students.length,
                    itemBuilder: (context, index) {
                      return  Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () async{
                             final SharedPreferences preferences = await SharedPreferences.getInstance();
           preferences.setInt("studentid",state.students!.students[index].id,);
                              Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  NewRegistrationScreen(student: state.students?.students[index].name,studentid:state.students?.students[index].id)),
                          );
                            
                          },
                          child: Container
                          (height: 100,padding: EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(10)
                          ),
                            
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(state.students?.students[index].name??"",style: TextStyle(fontWeight:FontWeight.bold),),
                                     Text(state.students?.students[index].email??"",style: TextStyle(fontWeight:FontWeight.bold)),
                                  ],
                                ),
                                  Row(
                                    children: [
                                       Text("Age:",style: TextStyle(fontWeight:FontWeight.bold)),

                                      Text(state.students?.students[index].age.toString()??"",style: TextStyle(fontWeight:FontWeight.bold)),
                                    ],
                                  ),
                              ],
                            )),
                        ),
                      );
                    
                  },),
                )
              
            
              ],
            ),
          ),
        );
          }
        

        return
         Center(child: Text(state.students?.students[0].name??"Something went wrong"),);
      }
    ),);
  }
}