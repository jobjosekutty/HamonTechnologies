import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_constants.dart';
import 'di/get_it.dart';
import 'presentation/provider/classroom_provider.dart';
import 'presentation/provider/home_provider.dart';
import 'presentation/provider/registration_provider.dart';
import 'presentation/provider/student_provider.dart';
import 'presentation/provider/subject_provider.dart';
import 'presentation/screens/home.dart';

void main() async{
    await configdependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(
            create: (context) => getIt<StudentProvider>()),
             ChangeNotifierProvider(
            create: (context) => getIt<SubjectProvider>()),
              ChangeNotifierProvider(
            create: (context) => getIt<ClassroomProvider>()),
             ChangeNotifierProvider(
            create: (context) => getIt<RegistrationProvider>()),
              ChangeNotifierProvider(
            create: (context) => HomeProvider()),
          
            
      ],
      child: MaterialApp(
                scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Home()
      ),
    );
  }
}

