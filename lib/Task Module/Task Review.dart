import 'package:employee_management/Task%20Module/TaskDetails.dart';
import 'package:flutter/material.dart';
import '../Leave Module/LeaveApplication.dart';
import '../Notification.dart';


class TaskAssignHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textColor = Color(0xff696969);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskDetails()),
                );
              },
              borderRadius: BorderRadius.circular(8),
              splashColor: Colors.grey.withOpacity(0.3),
              highlightColor: Colors.grey.withOpacity(0.1),
              child: Container(
                padding: EdgeInsets.all(16),
                width: screenWidth,
                height: screenHeight * 0.22,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
