import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sample_one/db/model/data_model.dart';
import 'package:sample_one/screens/add_screen.dart';
import 'package:sample_one/screens/search_screen.dart';
import 'package:sample_one/screens/studentview_screen.dart';

import '../db/functions/db_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'STUDENTS',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              iconSize: 30,
            ),
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchStudents(),
                );
              },
              icon: const Icon(Icons.search),
              iconSize: 30,
            ),
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder:
              (BuildContext context, List<StudentModel> value, Widget? child) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StudentviewScreen(
                            name: value[index].name,
                            age: value[index].age,
                            number: value[index].number,
                            domain: value[index].domain,
                            image: value[index].image,
                            index: index,
                          ),
                        ),
                      );
                    },
                    title: Text(value[index].name),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: FileImage(
                        File(value[index].image),
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        delete(index);
                      },
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: value.length,
              ),
            );
          },
        ),
      ),
    );
  }

  void delete(index) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: const Text('File will be Permenently deleted, Continue?'),
          actions: [
            TextButton(
              onPressed: () {
                deleteStudent(index);
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('No'),
            )
          ],
        );
      },
    );
  }
}
