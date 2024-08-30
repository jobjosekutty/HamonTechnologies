import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../core/app_constants.dart';
import '../../core/error_handler.dart';
import '../../di/get_it.dart';
import '../provider/classroom_provider.dart';
import '../widgets/snack_bar.dart';
import 'classroom_details.dart';

class Classrooms extends StatelessWidget {
  const Classrooms({super.key});

@override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(title:    const Text("ClassRoom"),centerTitle: true,),
      body: Consumer<ClassroomProvider>(
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
          if (state.classroom != null && state.classroom!.classrooms.isNotEmpty) {
           return
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            
           
              SizedBox(height: MediaQuery.of(context).size.height,
                child:
                ListView.builder(
            
                  itemCount: state.classroom?.classrooms.length,
                  itemBuilder: (context, index) {
                    return  Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ClassroomDetails(name:state.classroom?.classrooms[index].name,layout:state.classroom?.classrooms[index].layout.toString(),size:state.classroom?.classrooms[index].size,studentId:state.classroom?.classrooms[index].id)),
                        );
                          
                        },
                        child: Container
                        
                        (height: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey[350],),
                        
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.all(10),
                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.classroom?.classrooms[index].name??"",style: const TextStyle(fontWeight:FontWeight.bold)),
                                    Text(state.classroom?.classrooms[index].layout??"",style: const TextStyle(fontWeight:FontWeight.bold)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.classroom?.classrooms[index].size.toString()??"",style: const TextStyle(fontWeight:FontWeight.bold)),
                                  const Text("Seats",style: TextStyle(fontWeight:FontWeight.bold))

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
        Center(child: CupertinoButton(child: const Text("Retry"),onPressed: () {
               Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                    create: (context) => getIt< ClassroomProvider>()..getClassroom(),
                                    child: const Classrooms(),
                                
                                  )),
                        );
           
         },),);
      }
    ),);
  }
}