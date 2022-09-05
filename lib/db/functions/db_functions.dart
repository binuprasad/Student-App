import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sample_one/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
   await studentDB.add(value);
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(id);
  getAllStudents();
}

Future<void> updateStudent(int id, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentDB.putAt(id, value);
}
