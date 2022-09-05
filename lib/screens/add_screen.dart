import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_one/db/functions/db_functions.dart';
import 'package:sample_one/db/model/data_model.dart';
import 'package:sample_one/screens/home_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formkey = GlobalKey<FormState>();
  File? _image;
  bool isVisible = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      _image == null
                          ? const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 60,
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(
                                File(_image!.path),
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
                  const Text('Add Photo'),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: isVisible,
                    child: const Text(
                      'Please Add Photo',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: _nameController,
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
                    controller: _ageController,
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
                    controller: _domainController,
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
                    controller: _numberController,
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () {
                      if (_formkey.currentState!.validate() && _image != null) {
                        submit();
                      } else {
                        if (_image == null) {
                          setState(() {
                            isVisible = true;
                          });
                        } else {
                          setState(() {
                            isVisible = false;
                          });
                        }
                      }
                    },
                    child: const Text('Save'),
                  )
                ],
              ),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera_alt_sharp),
                      Text(
                        'Camera',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    getImage(ImageSource.gallery);
                    Navigator.pop(ctx);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.image_search),
                      Text(
                        'Gallery',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
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
        _image = imagepath;
      });
    }
  }

  void submit() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        content: Text('Adding Data...'),
      ),
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final studentModel = StudentModel(
      name: _nameController.text,
      age: _ageController.text,
      domain: _domainController.text,
      number: _numberController.text,
      image: _image!.path,
    );

    addStudent(studentModel);
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
