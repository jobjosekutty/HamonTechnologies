import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  final String? name;
    final String? age;
      final String? email;
  const StudentDetails({super.key, required this.name, this.age, this.email});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Student Details"),centerTitle: true,),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name.toString(),style: const TextStyle(fontWeight:FontWeight.bold)),
              Text(age.toString(),style: const TextStyle(fontWeight:FontWeight.bold)),
                  Text(email.toString(),style: const TextStyle(fontWeight:FontWeight.bold))
        ],
      ),
    ),);
  }
}