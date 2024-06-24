import 'package:flutter/material.dart';

class TaskDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Tasks / कार्य',
                  style: TextStyle(
                    color: Color.fromRGBO(170, 68, 101, 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/images/TaskHistory.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
              ),
              elevation: 5,
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
                    SizedBox(height: screenWidth * 0.04),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Remark/टिप्पणी',
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    GestureDetector(
                      onTap: () {
                        // Add your photo adding functionality here
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.upload, size: screenWidth * 0.08),
                            Text(
                              'Add Photo/फोटो जोड़ा',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Color(0xFF0000CD), width: 1)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 10, horizontal: 17)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
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
                        'Pospond\n पुढे ढकलले',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: screenWidth * 0.035, color: Color.fromRGBO(170, 68, 101, 1.0)),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for submitting
                  },
                  style: ButtonStyle(
                    // backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFADD8E6)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Color(0xFF0000CD), width: 1)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 10, horizontal: 17)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
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
                        'Submit\n सबमिट करें',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: screenWidth * 0.035, color: Color.fromRGBO(170, 68, 101, 1.0)),
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
  }
}


