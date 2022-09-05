import 'dart:io';

import 'package:flutter/material.dart';

import '../db/functions/db_functions.dart';
import '../db/model/data_model.dart';
import 'studentview_screen.dart';

class SearchStudents extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.close_outlined),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_sharp),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext context, List<StudentModel> value, Widget? child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                if (value[index].name.toLowerCase().contains(
                      query.toLowerCase(),
                    )) {
                  return Column(
                    children: [
                      ListTile(
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
                      ),
                      const Divider()
                    ],
                  );
                } else {
                  return const Text('No');
                }
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext context, List<StudentModel> value, Widget? child) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              if (value[index].name.toLowerCase().contains(
                    query.toLowerCase(),
                  )) {
                return Column(
                  children: [
                    ListTile(
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
                    ),
                    const Divider()
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}
