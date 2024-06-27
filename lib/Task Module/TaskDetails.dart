import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';

import '../Components/SubTaskCard.dart';

class TaskDetailsPage extends StatefulWidget {
  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  File? grievance;

  Future<void> dialog(String title) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var screenWidth = MediaQuery.of(context).size.width;
          return Dialog(
            backgroundColor: Colors.white,
            elevation: 0,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
          ),
            child: Container(
              height: screenWidth * 1.2,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Go to the Depo',
                              style: TextStyle(fontSize: screenWidth * 0.06),
                            ),
                            SizedBox(height: screenWidth * 0.04),
                            TextField(
                              maxLines: 3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(9.0))),
                                labelText: 'Remark/टिप्पणी',

                              ),
                            ),
                            SizedBox(height: screenWidth * 0.04),
                            GestureDetector(
                              onTap: () {
                                // Add your photo adding functionality here
                                selectImage();
                              },
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                // padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                                child: grievance == null
                                    ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload,
                                        size: screenWidth * 0.08),
                                    Text(
                                      'Add Photo/फोटो जोड़ा',
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.04),
                                    ),
                                  ],
                                )
                                    : Image.file(grievance!),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Add functionality for partially submitting
                        },
                        style: ButtonStyle(
                          // backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFADD8E6)),
                          elevation: MaterialStateProperty.all<double>(0),
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(color: Color(0xFF696969), width: 1)),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(vertical: 10, horizontal: 17)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/correct.png', // Replace with your icon path
                              width: screenWidth * 0.08,
                              height: screenWidth * 0.08,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color: Color.fromRGBO(170, 68, 101, 1.0)),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add functionality for submitting
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          // backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFADD8E6)),
                          elevation: MaterialStateProperty.all<double>(0),
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(color: Color(0xFF696969), width: 1)),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(vertical: 10, horizontal: 17)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/Cancel.png', // Replace with your icon path
                              width: screenWidth * 0.08,
                              height: screenWidth * 0.08,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              'Cancel\nरद्द करा',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color: Color.fromRGBO(170, 68, 101, 1.0)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
    },
    );
  }

  Future<void> selectImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 160,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    'Select Image From !',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await selectImageFromGallery();
                          Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/gallary.png',
                                  height: 60,
                                  width: 60,
                                ),
                                Text('Gallery'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await selectImageFromCamera();
                          Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/Cameraimage.png',
                                  height: 60,
                                  width: 60,
                                ),
                                Text('Camera'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> selectImageFromGallery() async {
    XFile? selectedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (selectedImage != null) {
      setState(() {
        grievance = File(selectedImage.path);
      });
      log("Image selected!");
    } else {
      log("No image selected!");
    }
  }

  Future<void> selectImageFromCamera() async {
    XFile? selectedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (selectedImage != null) {
      setState(() {
        grievance = File(selectedImage.path);
      });
      log("Image selected!");
    } else {
      log("No image selected!");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tasks / कार्य',
          style: TextStyle(
            color: Color.fromRGBO(170, 68, 101, 1.0),
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045,
          ),
        ),
        actions: [
          SizedBox(
            width: 35,
            child: Image.asset(
              'assets/images/TaskHistory.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Go to the Depo',
                          style: TextStyle(fontSize: screenWidth * 0.06),
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        Text(
                          'Employee 1',
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                        Text(
                          'Employee 2',
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        Text(
                          'Duration/कालावधी: 13/06/2024 - 19/06/2024',
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
              Column(
                children: [
                  SizedBox(height: screenWidth * 0.02),
                  SubTaskCard(
                  title:'SubTask 1',
                  onPartiallyCompleted: () {
                    dialog('Postpone\nपुढे ढकलले');
                  },
                  onNotCompleted: () {
                    dialog('Submit\nसबमिट करें');
                  }, status: 'rejected',
                  ),
                  SizedBox(height: screenWidth * 0.04),
                  SubTaskCard(
                    title:'SubTask 1',
                    onPartiallyCompleted: () {
                      dialog('Postpone\nपुढे ढकलले');
                    },
                    onNotCompleted: () {
                      dialog('Submit\nसबमिट करें');
                    }, status: 'approved',
                  ),
                  SizedBox(height: screenWidth * 0.04),
                  SubTaskCard(
                    title:'SubTask 1',
                    onPartiallyCompleted: () {
                      dialog('Postpone\nपुढे ढकलले');
                    },
                    onNotCompleted: () {
                      dialog('Submit\nसबमिट करें');
                    }, status: 'pending',
                  ),
                  SizedBox(height: screenWidth * 0.04),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for partially submitting
                      dialog('Postpone\nपुढे ढकलले');
                    },
                    style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFADD8E6)),
                      elevation: MaterialStateProperty.all<double>(0),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Color(0xFF696969), width: 1)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 17)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/correct.png', // Replace with your icon path
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          'Postpone\nपुढे ढकलले',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Color.fromRGBO(170, 68, 101, 1.0)),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for submitting
                      dialog('Submit\nसबमिट करें');
                    },
                    style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFADD8E6)),
                      elevation: MaterialStateProperty.all<double>(0),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Color(0xFF696969), width: 1)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 17)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/correct.png', // Replace with your icon path
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          'Submit\nसबमिट करें',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Color.fromRGBO(170, 68, 101, 1.0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
