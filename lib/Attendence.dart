import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceModule extends StatefulWidget {
  @override
  _AttendanceModuleState createState() => _AttendanceModuleState();
}

class _AttendanceModuleState extends State<AttendanceModule> {
  String? _selectedAttendaces ;
  String _date = "Fetching date...";
  String _time = "Fetching time...";
  Timer? _timer;
  DateTime? _apiDateTime;
  Duration? _offset;
  String _locationMessage = "Press the button to get location";
  bool _isLoading = false;
  String? _errorMessage;
  File? _image;

  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    fetchDateTime();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationAlertDialog();
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationMessage = 'Location permissions are denied';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationMessage = 'Location permissions are permanently denied, we cannot request permissions.';
        });
        return;
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Reverse geocoding to get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[1];

      setState(() {
        _locationMessage = '''${place.name},${place.street},
${place.thoroughfare},${place.subLocality},
${place.locality},${place.postalCode},
${place.administrativeArea},${place.country}''';
        _locationController.text = _locationMessage;
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Failed to get location: $e';
      });
    }
  }

  void _showLocationAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Services Disabled'),
          content: Text('Please turn on location services to get your current location.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchDateTime() async {
    try {
      final response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Kolkata'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final dateTime = DateTime.parse(jsonResponse['datetime']);
        final offsetHours = int.parse(jsonResponse['utc_offset'].substring(1, 3));
        final offsetMinutes = int.parse(jsonResponse['utc_offset'].substring(4, 6));
        final offsetSign = jsonResponse['utc_offset'][0] == '+' ? 1 : -1;
        final offset = Duration(hours: offsetSign * offsetHours, minutes: offsetSign * offsetMinutes);

        setState(() {
          _apiDateTime = dateTime;
          _offset = offset;
          _date = "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
          _time = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
        });

        startTimer();
      } else {
        setState(() {
          _date = "Failed to load date";
          _time = "Failed to load time";
        });
      }
    } catch (e) {
      setState(() {
        _date = "Failed to load date";
        _time = "Failed to load time";
      });
    }
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_apiDateTime != null && _offset != null) {
        final currentDateTime = _apiDateTime!.toUtc().add(_offset!).add(Duration(seconds: timer.tick));

        setState(() {
          _date = "${currentDateTime.day.toString().padLeft(2, '0')}/${currentDateTime.month.toString().padLeft(2, '0')}/${currentDateTime.year}";
          _time = "${currentDateTime.hour.toString().padLeft(2, '0')}:${currentDateTime.minute.toString().padLeft(2, '0')}:${currentDateTime.second.toString().padLeft(2, '0')}";
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _submitAttendance() async {
    try {
      // Get current user ID, replace with actual logic to fetch employee ID

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
      String employeeID = userId;
      // Get current date and format it as needed
      DateTime now = DateTime.now();
      String monthYear = '${now.month.toString().padLeft(2, '0')}-${now.year}';
      String currentDate = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString().substring(2)}';

      // Initialize attendance data structure
      Map<String, dynamic> attendanceData = {
        'name': 'John Doe', // Replace with actual user's name
        'month-Year': {
          'leaves': {
            'onedayleave': [],
            'halfDayLeave': [],
          },
        },
      };

      // Firebase Firestore collection and document reference
      String collectionPath = 'attendance';
      CollectionReference attendanceCollection = FirebaseFirestore.instance.collection(collectionPath);
      DocumentReference attendanceDocument = attendanceCollection.doc(employeeID);

      // Check if the current month-year document exists
      DocumentSnapshot docSnapshot = await attendanceDocument.get();

      // Initialize new attendance entry based on selected dropdown item
      Map<String, dynamic> newAttendanceEntry = {};

      if (_selectedAttendaces == 'Check In') {
        newAttendanceEntry = {
          'timestamp': _formatTime(_time),
          'location': _locationMessage,
          'photo': "", // Add logic to include photo if needed
          'Status': 'Active', // Assuming initial status
        };
      } else if (_selectedAttendaces == 'Mid Check In') {
        newAttendanceEntry = {
          'timestamp': _formatTime(_time),
          'location': _locationMessage,
          'photo': "", // Add logic to include photo if needed
          'Status': 'Active', // Assuming initial status
        };
      } else if (_selectedAttendaces == 'Check Out') {
        newAttendanceEntry = {
          'timestamp': _formatTime(_time),
          'location': _locationMessage,
          'photo': "", // Add logic to include photo if needed
          'Status': 'Active', // Assuming initial status
        };
      }

      if (!docSnapshot.exists) {
        // Create a new month-year map if it doesn't exist
        await attendanceDocument.set({
          monthYear: {
            'Days': {
              _date: {
                _selectedAttendaces: newAttendanceEntry
              }
            }
          }
        }, SetOptions(merge: true));
      } else {
        // Update the existing month-year map with the current date map
        await attendanceDocument.set({
          monthYear: {
            'Days': {
              currentDate: {
                _selectedAttendaces: newAttendanceEntry
              }
            }
          }
        }, SetOptions(merge: true));
      }

      // Send a notification on successful submission
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'Attendance Submitted',
          body: 'Your attendance has been successfully submitted.',
          notificationLayout: NotificationLayout.Default,
        ),
      );

      // Optionally, reset form state or show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Attendance submitted successfully'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print('Error submitting attendance: $e');
      // Handle errors or show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to submit attendance'),
        duration: Duration(seconds: 2),
      ));
    }
  }








  // Method to pick image from camera
  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path) as File?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
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
                  onTap: _pickImageFromCamera, // Pick image on tap
                  child: CircleAvatar(
                    radius: mediaQuery.size.width * 0.2,
                    backgroundImage: _image != null ? FileImage(_image! as File) : null,
                    child: _image == null
                        ? Icon(
                      Icons.camera_alt,
                      size: mediaQuery.size.width * 0.2,
                      color: Colors.grey,
                    )
                        : null,
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.size.height * 0.03),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Name/नाव', 'John Doe'),
                      SizedBox(height: mediaQuery.size.height * 0.01),
                      _buildDetailRow('Id/आईडी', '123456'),
                      SizedBox(height: mediaQuery.size.height * 0.01),
                      _buildLocationCard('Location/स्थान', _locationController),
                      SizedBox(height: mediaQuery.size.height * 0.01),
                      _buildDetailRow('Time/वेळ', _time),
                      SizedBox(height: mediaQuery.size.height * 0.01),
                      _buildDetailRow('Date/तारीख', _date),
                    ],
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.size.height * 0.03),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Attendance/शिफ्ट निवडा',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: mediaQuery.size.height * 0.02,
                    horizontal: mediaQuery.size.width * 0.03,
                  ),
                ),
                value: _selectedAttendaces,
                items: <String>['Check In', 'Mid Check In', 'Check Out']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedAttendaces = newValue;
                  });
                },
              ),
              SizedBox(height: mediaQuery.size.height * 0.05),
              Center(
                child: SizedBox(
                  width: mediaQuery.size.width * 5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(170, 68, 101, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: mediaQuery.size.height * 0.015,
                        horizontal: mediaQuery.size.width * 0.15,
                      ),
                    ),
                    onPressed: _submitAttendance,
                    child: Text(
                      'Submit Attendance/उपस्थिती सबमिट करा',
                      style: TextStyle(
                        fontSize: mediaQuery.size.height * 0.02,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color:Color.fromRGBO(150,150,150,3),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationCard(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color:Color.fromRGBO(150,150,150,3),
          ),
        ),
        TextField(
          controller: controller,
          maxLines: null,
          style: TextStyle(
            fontSize: 16,
          ),
          readOnly: true,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }

  String _formatTime(String time) {
    List<String> parts = time.split(':');
    if (parts.length == 3) {
      int hour = int.parse(parts[0]);
      String minute = parts[1];
      String second = parts[2];
      String period = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12;
      if (hour == 0) hour = 12;
      return "${hour.toString().padLeft(2, '0')}:${minute.padLeft(2, '0')}:${second.padLeft(2, '0')} $period";
    } else {
      return time;
    }
  }
}
