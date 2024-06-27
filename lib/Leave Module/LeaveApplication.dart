import 'package:flutter/material.dart';

class LeaveApplicationForm extends StatefulWidget {
  @override
  _LeaveApplicationFormState createState() => _LeaveApplicationFormState();
}

class _LeaveApplicationFormState extends State<LeaveApplicationForm> {
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  final _reasonController = TextEditingController();

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
          onPressed: () {},
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Time / वेळ :',
                  suffixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: TextField(
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
            ),
            Container(
              margin: EdgeInsets.only(bottom: 60),
              child: TextField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: 'Reason / कारण :',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
            ),
            Center(
              child:SizedBox(
                width:  mediaQuery.size.width * 5,
                height: mediaQuery.size.height*0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromRGBO(170, 68, 101, 1), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rectangle shape
                    ),
                  ),
                  onPressed: (){},
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
