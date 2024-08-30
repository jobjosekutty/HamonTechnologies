
// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;


import '../../core/app_color.dart';
import '../../core/app_constants.dart';
import '../../core/error_handler.dart';
import '../../di/get_it.dart';
import '../provider/registration_provider.dart';
import '../widgets/snack_bar.dart';
import 'new_registraion.dart';

class RegistrationsScreen extends StatefulWidget {
  const RegistrationsScreen({super.key});

  @override
  State<RegistrationsScreen> createState() => _RegistrationsScreenState();
}

class _RegistrationsScreenState extends State<RegistrationsScreen> {
  // @override
  // void initState() {
  //   data();
  //   super.initState();
  // }
  data()async{
    const String url = 'https://nibrahim.pythonanywhere.com/registration/?api_key=42efb';

  final response = await http.get(
    Uri.parse(url),
   
  );
log(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registration"),centerTitle: true,),
      body: Consumer<RegistrationProvider>(
        builder: (context, state, _) {
           if (state.homeFailure != null &&
            state.homeFailure is NetworkFailure) {
          return const Center(child: Text("No Internet"));
        }
           
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
            if(state.homeFailure is ServerErrorFailure){
            
                     scaffoldMessengerKey.currentState?.showSnackBar(
                appSnackBar(
                  "Server Failure  ===>500",
                  Colors.red,
                ),
              );

          }
        if(state.deleteScuccess){
          print("JOBJOSEKUTTY");
           
          WidgetsBinding.instance.addPostFrameCallback((time){
                     scaffoldMessengerKey.currentState?.showSnackBar(
                      
                appSnackBar(
                  "Deleted Successfully",
                  Colors.red,
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

    });
           

        }
         if (state.registration!.registrations.isEmpty) {
           return const Center(child: Text("No Data"));

         }
        if (state.registration != null && state.registration!.registrations.isNotEmpty) {
          return SingleChildScrollView(
          child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
               // SizedBox(height: 40,),
                SizedBox(height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
              
                    itemCount: state.registration?.registrations.length,
                    itemBuilder: (context, index) {
                      return  Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () async{
        
                            
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
                                  
                                    Row(
                                      children: [
                                             const Text("Student ID:",style: TextStyle(fontWeight:FontWeight.bold)),
                                        Text(state.registration!.registrations[index].student.toString(),style: const TextStyle(fontWeight:FontWeight.bold),),
                                      ],
                                    ),
                                         Row(
                                      children: [
                                             const Text("Subject ID:",style: TextStyle(fontWeight:FontWeight.bold)),
                                        Text(state.registration!.registrations[index].subject.toString(),style: const TextStyle(fontWeight:FontWeight.bold),),
                                      ],
                                    ),
                                
                                   
                                  ],
                                ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                           const Text("Registration ID:",style: TextStyle(fontWeight:FontWeight.bold)),
                                              
                                          Text(state.registration!.registrations[index].id.toString(),style: const TextStyle(fontWeight:FontWeight.bold)),
                                        ],
                                      ),
                                      IconButton(onPressed: (){
                                               Provider.of<RegistrationProvider>(context, listen: false).registrationDelete(state.registration!.registrations[index].id.toString(),context,);
                                      
                                      }, icon: const Icon(Icons.delete_forever_outlined,),color:Colors.red,)
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
        );
        }
            return
      Center(child: CupertinoButton(child: const Text("Retry"),onPressed: () {
               Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                    create: (context) => getIt< RegistrationProvider>()..getRegistartion(),
                                    child: const RegistrationsScreen(),
                                
                                  )),
                        );
           
         },),);
        }
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                elevation: const WidgetStatePropertyAll(0),
                backgroundColor:
                    WidgetStateProperty.all(AppColors.blue.withOpacity(0.15)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                foregroundColor: WidgetStateProperty.all(AppColors.blue),
              ),
              child: const Text('New Registration'),
              onPressed: () {
                 Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewRegistrationScreen()),
                        );
              
              },
            ),
          ],
        ),
      ),
    );
  }
}
