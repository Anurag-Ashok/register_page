import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registration Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  File? _profileImage;
  File? _documentImage;
  String? _name;
  String? _contactNumber;
  String? _selectedJob;

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        if (_profileImage == null)
          _profileImage = File(pickedFile.path);
        else
          _documentImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(1000, 234, 234, 234),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(10000, 234, 234, 234),
        title: Text('Registration Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Please select Profile Image",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  getImage(ImageSource.gallery);
                },
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _profileImage != null
                      ? Image.file(
                          _profileImage!,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.add_photo_alternate,
                          size: 50,
                          color: Colors.grey,
                        ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _contactNumber = value;
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Job',
                  border: OutlineInputBorder(),
                ),
                value: _selectedJob,
                items: [
                  DropdownMenuItem(
                    child: Text('Electricion'),
                    value: 'Job 1',
                  ),
                  DropdownMenuItem(
                    child: Text('Plumber'),
                    value: 'Job 2',
                  ),
                  DropdownMenuItem(
                    child: Text('Carpender'),
                    value: 'Job 3',
                  ),
                  DropdownMenuItem(
                    child: Text('AC Mechanic'),
                    value: 'Job 4',
                  ),
                  DropdownMenuItem(
                    child: Text('Welder'),
                    value: 'Job 5',
                  ),
                  // Add more job options here
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedJob = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                "Please select Document Image",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  getImage(ImageSource.gallery);
                },
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _documentImage != null
                      ? Image.file(
                          _documentImage!,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.add_photo_alternate,
                          size: 50,
                          color: Colors.grey,
                        ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save data to Firebase
                  // You need to implement Firebase integration here
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
