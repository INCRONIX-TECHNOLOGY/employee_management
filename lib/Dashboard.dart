import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import 'Leave Module/LeaveApplication.dart';
import 'Salary Module/PayRoll.dart';
import 'Task Module/Task Review.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textColor = Color(0xff696969);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Dashboard/डॅशबोर्ड',
          style: TextStyle(
            color: Color(0xffAA4465),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: (){},
              borderRadius: BorderRadius.circular(8),
              splashColor: Colors.grey.withOpacity(0.3),
              highlightColor: Colors.grey.withOpacity(0.1),
              child: Container(
                padding: EdgeInsets.all(16),
                width: screenWidth,
                height: screenHeight * 0.24,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Xyz',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Shift/शिफ्ट : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontSize: 18),
                          ),
                          TextSpan(
                            text: '1st shift',
                            style: TextStyle(color: textColor, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Check in/चेकइन : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontSize: 18),
                          ),
                          TextSpan(
                            text: '9:00 am',
                            style: TextStyle(color: textColor, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Mid-day/मधली सुट्टी : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontSize: 18),
                          ),
                          TextSpan(
                            text: '12:00 pm',
                            style: TextStyle(color: textColor, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Check out/चेकआउट : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontSize: 18),
                          ),
                          TextSpan(
                            text: '---',
                            style: TextStyle(color: textColor, fontSize: 18),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildListTile('Attendance/उपस्थिती', Bootstrap.person_check,() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PayrollPage()),
                    );
                  }),
                  _buildListTile('Tasks/कार्य', Bootstrap.duffle,
                   () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskAssignHomePage()),
                    );
                  }),
                  _buildListTile('Leave/रजा', Bootstrap.calendar2_week,() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LeaveApplicationForm()),
                    );
                  }),
                  _buildListTile('Salary/वेतन', Bootstrap.wallet2,() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PayrollPage()),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, Function onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            shape: BoxShape.rectangle,
          ),
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        onTap: () {
          // Handle tile tap
          onTap();
        },
      ),
    );
  }
}
