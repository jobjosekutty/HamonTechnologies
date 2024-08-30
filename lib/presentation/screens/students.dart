// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../core/app_constants.dart';
import '../../core/error_handler.dart';
import '../../di/get_it.dart';
import '../provider/student_provider.dart';
import '../widgets/snack_bar.dart';
import 'student_details.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}



class _StudentsState extends State<Students> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((time){
   

    });
      
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Students"),centerTitle: true,),
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
          if (state.students != null && state.students!.students.isNotEmpty) {
           return
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [                SizedBox(height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
              
                    itemCount: state.students?.students.length,
                    itemBuilder: (context, index) {
                      return  Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                              Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  StudentDetails(name:state.students?.students[index].name,age:state.students?.students[index].age.toString(),email:state.students?.students[index].email)),
                          );
                            
                          },
                          child: Container
                          (height: 100,padding: const EdgeInsets.all(10),
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
                                    Text(state.students?.students[index].name??"",style: const TextStyle(fontWeight:FontWeight.bold),),
                                     Text(state.students?.students[index].email??"",style: const TextStyle(fontWeight:FontWeight.bold)),
                                  ],
                                ),
                                  Row(
                                    children: [
                                       const Text("Age:",style: TextStyle(fontWeight:FontWeight.bold)),

                                      Text(state.students?.students[index].age.toString()??"",style: const TextStyle(fontWeight:FontWeight.bold)),
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
      Center(child: CupertinoButton(child: Text("Retry"),onPressed: () {
               Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                    create: (context) => getIt< StudentProvider>()..getStudent(),
                                    child: const Students(),
                                
                                  )),
                        );
           
         },),);
      }
    ),);
  }
}