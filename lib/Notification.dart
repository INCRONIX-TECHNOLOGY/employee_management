import 'package:flutter/material.dart';

import 'Salary Module/PayRoll.dart';
import 'Salary Module/PayRollReciept.dart';


class NotificationScreen extends StatelessWidget {
  // Dummy notification data for testing
  final List<Map<String, dynamic>> notifications = [
    {'title': 'Notification 1', 'status': 'New'},
    {'title': 'Notification 2', 'status': 'Old'},
    {'title': 'Notification 3', 'status': 'New'},
    {'title': 'Notification 4', 'status': 'Old'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,

          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: notifications.isEmpty
          ? Center(
        child: Text(
          'No Notifications',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: NotificationCard(
              title: notifications[index]['title'],
              status: notifications[index]['status'],
              onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => PayrollPageReciept()));
          }
                // Handle onTap action if needed

            ),
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String status;
  final VoidCallback? onTap;

  NotificationCard({
    required this.title,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(192, 192, 192, 0.27),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          status,
          style: TextStyle(
            color: status == 'New' ? Colors.green : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
