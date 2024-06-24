import 'package:flutter/material.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance History',
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
              _buildMonthAttendance('June 2024', mediaQuery),
              SizedBox(height: mediaQuery.size.height * 0.03),
              _buildMonthAttendance('May 2024', mediaQuery),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthAttendance(String month, MediaQueryData mediaQuery) {
    return ExpansionTile(
      title: Text(
        month,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      children: <Widget>[
        _buildDateText('June 14, 2024'),
        _buildLeaveCard(mediaQuery),
        SizedBox(height: mediaQuery.size.height * 0.03),
        _buildDateText('June 15, 2024'),
        _buildNoLeaveCard(mediaQuery),
        SizedBox(height: mediaQuery.size.height * 0.03),
        _buildDateText('June 16, 2024'),
        _buildDailyLeaveCard(mediaQuery),
      ],
    );
  }

  Widget _buildDateText(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF696969),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveCard(MediaQueryData mediaQuery) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(mediaQuery.size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: mediaQuery.size.height * 0.02),
            _buildTextRow('Shift', '1'),
            SizedBox(height: mediaQuery.size.height * 0.02),
            _buildTextRow('Check-in', '08:00 AM'),
            SizedBox(height: mediaQuery.size.height * 0.02),
            _buildTextRow('Mid Check-in', '12:00 PM'),
            SizedBox(height: mediaQuery.size.height * 0.02),
            _buildTextRow('Check-out', '05:00 PM'),
            SizedBox(height: mediaQuery.size.height * 0.02),
            _buildTextRow('Leave', 'Yes, after Mid Check-in'),
          ],
        ),
      ),
    );
  }

  Widget _buildNoLeaveCard(MediaQueryData mediaQuery) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(mediaQuery.size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: mediaQuery.size.height * 0.02),
            _buildTextRow('Shift', '2'),
            SizedBox(height: mediaQuery.size.height * 0.02),
            _buildTextRow('Check-in', '09:00 AM'),
            SizedBox(height: mediaQuery.size.height * 0.02),
            _buildTextRow('Mid Check-in', '01:00 PM'),
            SizedBox(height: mediaQuery.size.height * 0.02),
            _buildTextRow('Check-out', '06:00 PM'),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyLeaveCard(MediaQueryData mediaQuery) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(mediaQuery.size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: mediaQuery.size.height * 0.02),
            _buildTextRow('Leave:', 'Full day leave'),
            // SizedBox(height: mediaQuery.size.height * 0.02),
            // _buildTextRow('Total Leaves', '2'),
            // SizedBox(height: mediaQuery.size.height * 0.02),
            // _buildTextRow('Leave Dates', 'June 10, 2024\nJune 11, 2024'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          value,
          style: TextStyle(color: Color(0xFF696969)),
        ),
      ],
    );
  }
}

void main() => runApp(MaterialApp(
  home: AttendanceHistoryScreen(),
));
