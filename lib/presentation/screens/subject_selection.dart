// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_constants.dart';
import '../../core/error_handler.dart';
import '../provider/subject_provider.dart';
import '../widgets/snack_bar.dart';
import 'new_registraion.dart';

class SubjectSelection extends StatelessWidget {
  const SubjectSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Subjets"),centerTitle: true,),
      body: Consumer<SubjectProvider>(
      builder: (context, state, _) {
        
 if (state.homeFailure != null &&
              state.homeFailure is NetworkFailure) {
            return const Center(child: Text("No Internet"));
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
                        onTap: ()async {
                            final SharedPreferences preferences = await SharedPreferences.getInstance();
                             preferences.setInt("subjectid",state.subjects!.subjects[index].id,);
                            Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewRegistrationScreen(subject:state.subjects?.subjects[index].name,subjectid:state.subjects?.subjects[index].id)),
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
         Center(child: Text(state.subjects?.subjects[0].name??"Something went wrong!"),);
      }
    ),);
  }
}