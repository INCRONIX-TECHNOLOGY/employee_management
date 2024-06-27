import 'package:employee_management/Task%20Module/TaskDetails.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import 'TaskDetails.dart';

class SubTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Go to the Depo',
                      style: TextStyle(fontSize: screenWidth * 0.06),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'Employee 1',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                    Text(
                      'Employee 2',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'Date/तारीख : 13/06/2024',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Text(
                'Please Click on the Tiles',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SubTaskCard(screenWidth: screenWidth, screenHeight: screenHeight),
            SubTaskCard(screenWidth: screenWidth, screenHeight: screenHeight),
            SubTaskCard(screenWidth: screenWidth, screenHeight: screenHeight),
          ],
        ),
      ),
    );
  }
}

class SubTaskCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const SubTaskCard({
    required this.screenWidth,
    required this.screenHeight,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
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
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween            ,
                children: [
                  Text(
                    'SubTask Name',
                    style: TextStyle(fontSize: screenWidth * 0.05),
                  ),
                  Icon(Bootstrap.clock_history)
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add functionality for postponing

                    },
                    icon: Image.asset(
                      'assets/images/correct.png', // Replace with your image path
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      'पुढे ढकला',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Colors.grey, width: 1)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add functionality for submitting
                    },
                    icon: Image.asset(
                      'assets/images/correct.png', // Replace with your image path
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      'सबमिट करा',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Colors.grey, width: 1)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
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
