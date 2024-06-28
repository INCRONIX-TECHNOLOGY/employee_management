import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveApplicationForm extends StatefulWidget {
  @override
  _LeaveApplicationFormState createState() => _LeaveApplicationFormState();
}

class _LeaveApplicationFormState extends State<LeaveApplicationForm> {
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  final _reasonController = TextEditingController();
  String? _selectedLeavetype;
  bool _isLoading = false;
  String? _errorMessage;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  void dispose() {
    _timeController.dispose();
    _dateController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ) ?? DateTime.now();
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      setState(() {
        _timeController.text = TimeOfDay.fromDateTime(selectedTime).format(context);
      });
    }
  }

  Future<void> _submitLeaveRequest() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Retrieve user ID and name from secure storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = await prefs.getString('userId');
      String? userName = await prefs.getString('userName');

      if (userId == null || userName == null) {
        setState(() {
          _errorMessage = 'User information not found. Please log in again.';
          _isLoading = false;
        });
        return;
      }

      if (_selectedLeavetype == null) {
        setState(() {
          _errorMessage = 'Please select the leave type';
          _isLoading = false;
        });
        return;
      }

      // Collect data from the form
      String leaveType = _selectedLeavetype ?? '';
      String time = _timeController.text;
      String date = _dateController.text;
      String reason = _reasonController.text;

      // Add leave request to Firestore
      await _firestore.collection('leave_requests').add({
        'userId': userId,
        'userName': userName,
        'leaveType': leaveType,
        'time': time,
        'date': date,
        'reason': reason,
        'status':'pending',
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear the form
      setState(() {
        _selectedLeavetype = null;
        _timeController.clear();
        _dateController.clear();
        _reasonController.clear();
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Leave request submitted successfully.')),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Application'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color.fromRGBO(170, 68, 101, 1.0),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Leave Type/रजा प्रकार निवडा',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: mediaQuery.size.height * 0.02,
                  horizontal: mediaQuery.size.width * 0.03,
                ),
              ),
              value: _selectedLeavetype,
              items: <String>['Half Day/अर्धा दिवस सुट्टी', 'Full Day/पूर्ण दिवस सुट्टी']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedLeavetype = newValue;
                });
              },
            ),
            SizedBox(height: mediaQuery.size.height * 0.02),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'Time / वेळ :',
                suffixIcon: GestureDetector(
                  onTap: () => _selectTime(context),
                  child: Icon(Icons.access_time),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: mediaQuery.size.height * 0.02),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date / तारीख :',
                border: OutlineInputBorder(),
                suffixIcon: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Icon(Icons.calendar_today),
                ),
              ),
            ),
            SizedBox(height: mediaQuery.size.height * 0.02),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(
                labelText: 'Reason / कारण :',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: mediaQuery.size.height * 0.03),
            if (_isLoading) CircularProgressIndicator(),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            Center(
              child: SizedBox(
                width: mediaQuery.size.width * 0.8,
                height: mediaQuery.size.height * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromRGBO(170, 68, 101, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _submitLeaveRequest,
                  child: Text('Submit/प्रस्तुत करा'),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
