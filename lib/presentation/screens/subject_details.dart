import 'package:flutter/material.dart';

class SubjectDetails extends StatelessWidget {
  final String? name;
  final String? teacher;
  final String? credit;
  const SubjectDetails({super.key, required this.name, required this.teacher, required this.credit});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(title: const Text("SubjectDetails"),centerTitle: true,),
      body: Center(
      child: Center(
        child: Column(
          
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name.toString(),style: const TextStyle(fontWeight:FontWeight.bold,)),
                Text(teacher.toString(),style: const TextStyle(fontWeight:FontWeight.bold)),
                    Text(credit.toString(),style: const TextStyle(fontWeight:FontWeight.bold))
          ],
        ),
      ),
    ),);
  }
}