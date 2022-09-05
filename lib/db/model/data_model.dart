import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String age;
  @HiveField(2)
  final String domain;
  @HiveField(3)
  final String number;
  @HiveField(4)
  final String image;

  StudentModel({
    required this.name,
    required this.age,
    required this.domain,
    required this.number,
    required this.image,
  });
}
