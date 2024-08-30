// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../core/app_constants.dart';
import '../../di/get_it.dart';
import '../provider/classroom_provider.dart';
import '../provider/home_provider.dart';
import '../provider/registration_provider.dart';
import '../provider/student_provider.dart';
import '../provider/subject_provider.dart';
import 'classrooms.dart';
import 'registration.dart';
import 'students.dart';
import 'subjects.dart';


class Home extends StatelessWidget {
    Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<HomeProvider>(
            builder: (context, value, child) {
              return Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "GoodMorning",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    IconButton(onPressed: () {
                                   value.viewAlignment();
                    
                                        
                                        }, icon:  Icon( value.isGrid? CupertinoIcons.line_horizontal_3: CupertinoIcons.rectangle_3_offgrid,))
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child:value.isGrid? GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2, // This will allow 2 items per row
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (context) => getIt<StudentProvider>()..getStudent(),
                                      child: const Students(),
                                    )),
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                             color: gridColors[0],
                          borderRadius: BorderRadius.circular(10)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.school),
                                Text('Student'),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (context) => getIt< SubjectProvider>()..getSubject(),
                                      child: const Subjects(),
                                  
                                    )),
                          );
                         
                        },
                        child: Container(
                           decoration: BoxDecoration(
                             color: gridColors[1],
                          borderRadius: BorderRadius.circular(10)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.import_contacts_outlined),
                                Text('Subject'),
                              ],
                            )),
                      ),
                      GestureDetector(
            
            onTap: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (context) => getIt< ClassroomProvider>()..getClassroom(),
                                      child: const Classrooms(),
                                  
                                    )),
                          );
            },                      child: Container(
                            decoration: BoxDecoration(
                             color: gridColors[2],
                          borderRadius: BorderRadius.circular(10)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.meeting_room),
                                Text('Classroom'),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (context) => getIt<RegistrationProvider>()..getRegistartion(),
                                      child: const RegistrationsScreen(),
                                    )),
                          );
                        },
                        child: Container(
                         decoration: BoxDecoration(
                             color: gridColors[3],
                          borderRadius: BorderRadius.circular(10)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit),
                                Text('Registration'),
                              ],
                            )),
                      ),
                    ],
                  ): ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                               Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (context) => getIt<StudentProvider>()..getStudent(),
                                      child: const Students(),
                                    )),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: 60,width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: gridColors[0]),child: const Center(child: Text("Students",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),),
                      ),
                         GestureDetector(
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (context) => getIt< SubjectProvider>()..getSubject(),
                                      child: const Subjects(),
                                  
                                    )),
                          );
                            
                          },
                           child: Container( margin: const EdgeInsets.only(bottom: 10),
                            height: 60,width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: gridColors[1]),child: const Center(child: Text("Subjects",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),),
                         ),
                            GestureDetector(
                              onTap: () {
                                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (context) => getIt< ClassroomProvider>()..getClassroom(),
                                      child: const Classrooms(),
                                  
                                    )),
                          );
                                
                              },
                              child: Container( margin: const EdgeInsets.only(bottom: 10),
                                height: 60,width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: gridColors[2]),child: const Center(child: Text("Class Rooms",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),),
                            ),   GestureDetector(
                              onTap: () {
                                 Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (context) => getIt<RegistrationProvider>()..getRegistartion(),
                                      child: const RegistrationsScreen(),
                                    )),
                          );
                                
                              },
                              child: Container(
                                  height: 60,width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: gridColors[3]),child: const Center(child: Text("Registration",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),),
                            )
                    ],
                  )
                ),
              ],
            );
            },
           
          )
        ),
      ),
    );
  }
}
