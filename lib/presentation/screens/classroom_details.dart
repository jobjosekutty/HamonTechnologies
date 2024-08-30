// ignore_for_file: avoid_print, must_be_immutable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_color.dart';
import '../../di/get_it.dart';
import '../provider/subject_provider.dart';

import 'add_subject.dart';

class ClassroomDetails extends StatelessWidget {
  final String? name;
  final String? layout;
  final int? size;
  final int? studentId;
  final int? subject;
   ClassroomDetails({super.key, this.name, this.layout, this.size, this.studentId, this.subject});
String? sub;
String? teacher;
  @override
  Widget build(BuildContext context) {
    if(subject ==1){

      sub = "History";
      teacher = "Brenda Miller";

    }else if(subject ==2){
       sub = "Mathematics";
       
      teacher = "Brenda Miller";

    }else if(subject ==3){
       sub = "Social Science";
       
      teacher = " Jamie Holden";

    }else if(subject ==4){
       sub = "Physics";
         teacher = "Adam Ingram";

    }else if(subject ==5){
       sub = "Chemistry";
         teacher = "Erin Walsh";

    }else if(subject ==6){
       sub = "Biology";
  teacher = "Pamela";
    }
     int seatsFirstColumn =
                ((size ?? 0) / 2).ceil();
            log('seatsFirstColumn: $seatsFirstColumn'); // seatsFirstColumn: 9
            int seatsSecondColumn =
                (size ?? 0) - seatsFirstColumn;
    print("sizeee$size");
    return Scaffold(
      body:  SafeArea(
        child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: Row(
                    children: [
                      IconButton(onPressed: (){
                         Navigator.pop(context);
                      }, icon:const Icon(Icons.arrow_back))
                    ],
                  ),),
        
        
                     SliverToBoxAdapter(
                child: Column(
                  children: [
                
                               
                                Text(name.toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
                                
                  ],
                ),
              ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverToBoxAdapter(
                      child:    Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                 subject ==null?       const Text("Add Subject",style: TextStyle(fontWeight: FontWeight.bold),):Column(children: [
                    Text(sub.toString()),
                      Text(teacher.toString())
        
                 ],),
                   subject ==null?         CupertinoButton(
                          onPressed: () {
                                    Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (context) => getIt< SubjectProvider>()..getSubject(),
                                      child: AddSubject(id:studentId),
                                  
                                    )),
                          );
        
                          },
                          color: Colors.green.withOpacity(.3),
                          child: const Text("Add",style: TextStyle(color:Colors.green),),
                        ):CupertinoButton(
                          color: Colors.green.withOpacity(.3),
                          child: const Center(child: Text("Change",style: TextStyle(color: AppColors.green),)),onPressed: () {
                                 Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (context) => getIt< SubjectProvider>()..getSubject(),
                                      child: AddSubject(id:studentId),
                                  
                                    )),
                          );
                          
                        },)
                      ],
                    ),
                  ),
                ),
                    ),
                  ),
                  if (layout == "classroom")
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/sitting-on-a-chair 8.png',
                                  ),
                                ),
                                border: Border.all(
                                  color: AppColors.tileColor,
                                  width: 1,
                                ),
                              ),
                            );
                          },
                          childCount: (size ?? 0),
                        ),
                      ),
                    ),
                  if (layout == "conference")
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverToBoxAdapter(
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              generateSeats(totalSeats: seatsFirstColumn),
                              Container(
                                width: 100,
                                color: AppColors.tileColor,
                              ),
                              generateSeats(
                                totalSeats: seatsSecondColumn,
                                isSecondColumn: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                                      SliverPadding(
                      padding: const EdgeInsets.all(4),
                      sliver: SliverToBoxAdapter(
                        child: IntrinsicHeight(
                          child: 
                                     subject!= null ? Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey[350]),
                                      
                                      height: 50,width: double.infinity,child: const Center(child: Text("Subject Updated",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 18),)),):Container(),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
   Column generateSeats({required int totalSeats, bool isSecondColumn = false}) {
    return Column(
      children: List.generate(
        totalSeats,
        (index) => Transform.flip(
          flipX: isSecondColumn,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/sitting-on-a-chair 8.png',
                ),
              ),
            ),
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }
}
