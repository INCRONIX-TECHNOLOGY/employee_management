import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'Custom_Button.dart';

class SubTaskCard extends StatelessWidget {
  final String title;
  final String status;
  final VoidCallback onPartiallyCompleted;
  final VoidCallback onNotCompleted;

  SubTaskCard({
    required this.title,
    required this.onPartiallyCompleted,
    required this.onNotCompleted,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    IconData getStatusIcon() {
      switch (status) {
        case 'pending':
          return Icons.access_time;
        case 'approved':
          return Icons.check_circle;
        case 'rejected':
          return Icons.cancel;
        default:
          return Icons.help; // Default icon if status is unknown
      }
    }
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
                  Icon(getStatusIcon())
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    title: 'पुढे ढकला',
                    imagePath: 'assets/images/correct.png',
                    onPressed: onPartiallyCompleted,
                  ),
                  CustomButton(
                    title: 'सबमिट करा',
                    imagePath: 'assets/images/correct.png',
                    onPressed: onNotCompleted,
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
