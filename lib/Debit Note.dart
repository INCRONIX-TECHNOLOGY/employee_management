import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DebitModuleScreen extends StatefulWidget {
  @override
  _DebitModuleScreenState createState() => _DebitModuleScreenState();
}

class _DebitModuleScreenState extends State<DebitModuleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _remarkController = TextEditingController();
  File? _proofImage;

  @override
  void dispose() {
    _timeController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _proofImage = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the data
      final time = _timeController.text;
      final date = _dateController.text;
      final location = _locationController.text;
      final remark = _remarkController.text;
      final proof = _proofImage;

      // Here, you can save the data to a database or perform any other required actions

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form submitted successfully')));

      // Clear the form fields
      _formKey.currentState!.reset();
      setState(() {
        _proofImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Debit Module',
          style: TextStyle(color: Color.fromRGBO(170, 68, 101, 1)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color.fromRGBO(170, 68, 101, 1)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextField(_timeController, 'Time', 'Enter time'),
                SizedBox(height: mediaQuery.size.height * 0.02),
                _buildTextField(_dateController, 'Date', 'Enter date'),
                SizedBox(height: mediaQuery.size.height * 0.02),
                _buildTextField(_locationController, 'Location', 'Enter location'),
                SizedBox(height: mediaQuery.size.height * 0.02),
                _buildremarkTextField('Remark', _remarkController),
                SizedBox(height: mediaQuery.size.height * 0.02),
                Text('Proof', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: mediaQuery.size.height * 0.01),
                _buildProofField(mediaQuery),
                SizedBox(height: mediaQuery.size.height * 0.1),
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
                      onPressed: _submitForm,
                      child: Text('Submit / सबमीट करा'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildProofField(MediaQueryData mediaQuery ) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 150,
        width: double.infinity,
        child: _proofImage != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            _proofImage!,
            fit: BoxFit.contain),
        )
            : const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.file_upload_sharp, size: 70, color: Colors.grey),
              SizedBox(height: 10),
              Text(
                'No proof selected\nTap to add proof',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
      ),
      ),
    );
  }


  Widget _buildremarkTextField(String label, TextEditingController controller) {
    final mediaQuery = MediaQuery.of(context);
    return TextFormField(
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
      maxLines: 3, // Allow the text field to expand
      onChanged: (value) {
        setState(() {}); // Update the height dynamically
      },
    );
  }


}

void main() => runApp(MaterialApp(
  home: DebitModuleScreen(),
));
