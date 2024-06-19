import 'package:flutter/material.dart';

import 'LeaveApplication.dart';
import 'Notification.dart';


class TaskAssignHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Assigned Task/नियुक्त केलेले कार्य',
          style: TextStyle(
            color: Color.fromRGBO(170, 68, 101, 1.0),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(9.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Gray color for the border
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        'assets/images/user.png', // Replace with your image path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Go to the Depo',
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Employee 1, Employee 2',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Location/स्थान: XYZ Area / परिसर',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Date/तारीख: 13/06/2024',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) =>   NotificationScreen()));

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,

                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: Container(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Color.fromRGBO(170, 68, 101, 1.0),// RGBA color (Red with 50% opacity)
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
