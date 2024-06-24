import 'package:flutter/material.dart';

class ProfileModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Color.fromRGBO(170, 68, 101, 1)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color.fromRGBO(170, 68, 101, 1)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Implement navigation to change profile picture screen
                  },
                  child: CircleAvatar(
                    radius: mediaQuery.size.width * 0.15,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'),
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.size.height * 0.03),
              _buildTextField('Name', 'John Doe', mediaQuery),
              SizedBox(height: mediaQuery.size.height * 0.03),
              _buildTextField('ID', '123456', mediaQuery),
              SizedBox(height: mediaQuery.size.height * 0.03),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AttendanceHistoryScreen()),
                  );
                },
                child: Card(
                  color: Color(0xFF696969), // Setting card background color
                  child: ListTile(
                    title: Text('Attendance History/उपस्थिती इतिहास', style: TextStyle(color: Colors.white)),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.size.height * 0.03),
              _buildTotalWorkingHours(mediaQuery),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value, MediaQueryData mediaQuery) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: mediaQuery.size.height * 0.02,
          horizontal: mediaQuery.size.width * 0.03,
        ),
      ),
      readOnly: true,
    );
  }

  Widget _buildTotalWorkingHours(MediaQueryData mediaQuery) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: const Text(
            'Total Working Hours/एकूण कामकाजाचे तास',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        Card(
          color: Color(0xFF696969), // Setting card background color
          child: ListTile(
            title: Text('Day wise/दिवसानुसार', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.calendar_month, color: Colors.white),
          ),
        ),
        SizedBox(height: 15),
        _buildTextField('Today', '8 Hour/तास', mediaQuery), // Assuming this shows today's total working hours
      ],
    );
  }
}

class AttendanceHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement your UI for displaying the attendance history
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance History'),
      ),
      body: Center(
        child: Text('Attendance history screen'),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: ProfileModule(),
));
