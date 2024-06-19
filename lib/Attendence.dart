import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class AttendanceModule extends StatefulWidget {
  @override
  _AttendanceModuleState createState() => _AttendanceModuleState();
}

class _AttendanceModuleState extends State<AttendanceModule> {
  String? _selectedShift;
  ImageProvider<Object>? _image = NetworkImage('https://via.placeholder.com/150');
  String _date = "Fetching date...";
  String _time = "Fetching time...";
  Timer? _timer;
  DateTime? _apiDateTime;
  Duration? _offset;
  String _locationMessage = "Press the button to get location";
  String _locationMessage1 = "Second label";

  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
   // _getCurrentLocation();
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
      _locationMessage1 = "${placemarks}";
      print(placemarks);

      setState(() {
        _locationMessage = '''
         ${place.name},
        ${place.street},
          ${place.thoroughfare},
        ${place.subLocality},
        ${place.locality},
         ${place.postalCode},
        ${place.administrativeArea},
        ${place.country}
        ''';
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
    // Your attendance submission logic here

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
                  // onTap: _pickImage,
                  child: CircleAvatar(
                    radius: mediaQuery.size.width * 0.2,
                    backgroundImage: _image,
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.size.height * 0.03),
              _buildTextField('Name/नाव', 'John Doe'),
              SizedBox(height: mediaQuery.size.height * 0.03),
              _buildTextField('Id/आईडी', '123456'),
              SizedBox(height: mediaQuery.size.height * 0.03),
              _buildLocationTextField('Location/स्थान', _locationController),
              SizedBox(height: mediaQuery.size.height * 0.03),
              _buildTextField('Time/वेळ',_formatTime(_time)),
              SizedBox(height: mediaQuery.size.height * 0.03),
              _buildTextField('Date/तारीख', _date),
              SizedBox(height: mediaQuery.size.height * 0.03),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Shift/शिफ्ट निवडा',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: mediaQuery.size.height * 0.02,
                    horizontal: mediaQuery.size.width * 0.03,
                  ),
                ),
                value: _selectedShift,
                items: <String>['Shift 1', 'Shift 2', 'Shift 3']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedShift = newValue;
                  });
                },
              ),
              SizedBox(height: mediaQuery.size.height * 0.05),
              Center(
                child: SizedBox(
                  width:  mediaQuery.size.width * 5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromRGBO(170, 68, 101, 1), // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rectangle shape
                      ),
                    ),
                    onPressed: _submitAttendance,
                    child: Text('Submit/प्रस्तुत करा'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String defaultValue) {
    final mediaQuery = MediaQuery.of(context);
    return TextFormField(
      initialValue: defaultValue,
      readOnly: true,
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
    );
  }

  Widget _buildLocationTextField(String label, TextEditingController controller) {
    final mediaQuery = MediaQuery.of(context);
    return TextFormField(
      readOnly: true,
      controller: controller,
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
      maxLines: null, // Allow the text field to expand
      onChanged: (value) {
        setState(() {}); // Update the height dynamically
      },
    );
  }

  String _formatTime(String time) {
    final parts = time.split(':');
    final hours = int.parse(parts[0]);
    final minutes = parts[1];
    final ampm = hours >= 12 ? 'PM' : 'AM';
    final formattedHours = hours % 12 == 0 ? 12 : hours % 12;
    return '$formattedHours:$minutes $ampm';
  }
}
