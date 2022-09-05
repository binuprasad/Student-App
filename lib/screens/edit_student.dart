import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_one/db/functions/db_functions.dart';

import '../db/model/data_model.dart';
import 'home_screen.dart';


class EditScreen extends StatefulWidget {
  EditScreen({
    Key? key,
    required this.name,
    required this.age,
    required this.domain,
    required this.number,
    required this.image,
    required this.index,
  }) : super(key: key);

  final String name;
  final String age;
  final String domain;
  final String number;
  String image;
  int index;
  File? img;
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController nameController;

  late TextEditingController ageController;

  late TextEditingController domainController;

  late TextEditingController numberController;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    ageController = TextEditingController(text: widget.age);
    domainController = TextEditingController(text: widget.domain);
    numberController = TextEditingController(text: widget.number);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: FileImage(
                        File(widget.image),
                      ),
                      radius: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 46,
                        top: 120,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          imagepicker();
                        },
                        child: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                const Text('Edit Photo'),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill your Name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill your Age';
                    } else if (value.length > 2) {
                      return 'Impossible value';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Age',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: domainController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill your Domain';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Domain',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill your Mobile Number';
                    } else if (value.length != 10) {
                      return 'Number must be 10 digits';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Mobile Number',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      save(context);
                    }
                  },
                  icon: const Icon(Icons.save_alt_outlined),
                  label: const Text('Save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void imagepicker() async {
    showDialog(
      context: context,
      builder: (ctx) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            width: 200,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    getImage(ImageSource.camera);
                    Navigator.pop(ctx);
                  },
                  child: const Icon(Icons.camera_alt_sharp),
                ),
                GestureDetector(
                  onTap: () {
                    getImage(ImageSource.gallery);
                    Navigator.pop(ctx);
                  },
                  child: const Icon(Icons.image_search),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    } else {
      final imagepath = File(image.path);
      setState(() {
        widget.image = imagepath.path;
      });
    }
  }

  void save(ctx) async {
    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        content: Text('Saving'),
      ),
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final studentModel = StudentModel(
      name: nameController.text,
      age: ageController.text,
      domain: domainController.text,
      number: numberController.text,
      image: widget.image,
    );

    updateStudent(widget.index, studentModel);
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );
  }
}
