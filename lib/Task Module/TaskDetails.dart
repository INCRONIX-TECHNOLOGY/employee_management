import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  File? grievance;

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textColor = Color(0xff696969);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Task Details/कार्य तपशील',
        style: TextStyle(
          color: Color(0xFFAA4465)
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: screenWidth,
              height: screenHeight * 0.8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Go to the Depo',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Employee 1\nEmployee 2',
                    style: TextStyle(
                        fontSize: 16,
                        color: textColor
                    ),
                  ),
                  Text(
                    'Duration/कालावधी: 13/06/2024 - 20/06/2024',
                    style: TextStyle(fontSize: 16,
                        color: textColor),
                  ),
                  SizedBox(height: 15,),
                  TextField(
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Remark/टिप्पणी',
                      hintStyle: TextStyle(
                        fontSize: 20
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                        borderSide: BorderSide(
                            color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                        borderSide: BorderSide(
                            color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                        borderSide: BorderSide(
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: selectImage,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      child: Container(
                        height: 150,
                        child: grievance == null
                            ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.file_upload, size: 50,color: textColor,),
                              SizedBox(height: screenHeight * 0.00),
                              Text('Add Photo/फोटो जोडा',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 20
                              ),),
                            ],
                          ),
                        )
                            : Image.file(grievance!),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
