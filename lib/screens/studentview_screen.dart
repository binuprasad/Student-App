import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sample_one/screens/edit_student.dart';

class StudentviewScreen extends StatelessWidget {
  const StudentviewScreen({
    Key? key,
    required this.name,
    required this.age,
    required this.number,
    required this.domain,
    required this.image,
    required this.index,
  }) : super(key: key);

  final String name;
  final String age;
  final String number;
  final String domain;
  final String image;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text(name),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditScreen(
                        name: name,
                        age: age,
                        domain: domain,
                        number: number,
                        image: image,
                        index: index,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.mode_edit_outline_rounded,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: FileImage(
                      File(image),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NAME : $name',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'AGE : $age',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'DOMAIN : $domain',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'MOB : $number',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
