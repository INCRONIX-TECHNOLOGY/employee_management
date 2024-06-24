import 'package:flutter/material.dart';

class EmptyTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Add back button functionality here
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              // Add button functionality here
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.report_problem,
              size: mediaQuery.size.width * 0.5,
              color: Colors.grey,
            ),
            SizedBox(height: mediaQuery.size.height * 0.02),
            Text(
              'No Task  yet',
              style: TextStyle(
                color: Colors.grey,
                fontSize: mediaQuery.size.width * 0.05,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

