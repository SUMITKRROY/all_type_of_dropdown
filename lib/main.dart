import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:image_picker/image_picker.dart';

import 'All_type_of_dropdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PackingPage(),
    );
  }
}

class PackingPage extends StatefulWidget {
  @override
  State<PackingPage> createState() => _PackingPageState();
}

class _PackingPageState extends State<PackingPage> {
  final _formKey = GlobalKey<FormState>();

  String? _field1Value;

  String? _field2Value;

  String? _field3Value;

  String? _dropdownValue;


  bool checkid = true;
  File? _image;
  final imagePicker = ImagePicker();
  var selfiImgBase64 = '';
  CameraController? _controller;
  List<CameraDescription> cameras = [];










  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Update Packing"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add your search functionality here
            },
          ),
        ],
      ),
      body: ListView(

        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(

                children: [
                  Text(
                    "Packing Required fields",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black), // Add border
                            borderRadius: BorderRadius.circular(4.0), // Add rounded corners
                          ),
                          child: DropdownButtonFormField<String>(
                            hint:  Text("*Select Packing"),
                            value: _dropdownValue,
                            onChanged: (String? newValue) {
                              // Handle dropdown selection
                              setState(() {
                                _dropdownValue = newValue;
                              });
                            },
                            items: <String>[
                              'Option 1',
                              'Option 2',
                              'Option 3',
                              'Option 4',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding
                              border: InputBorder.none, // Remove input border
                            ),
                            validator: (value) {
                              if (_dropdownValue == null) {
                                return "Dropdown selection is required";
                              }
                              return null;
                            },
                          ),
                        ),

                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "* Number of Box",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Number of Box is required";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _field1Value = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "* Packing Slip Number",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Packing Slip Number is required";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _field2Value = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Total Weight (In KG)",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Total Weight (In KG) is required";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _field3Value = value;
                          },
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    width: 358,
                    margin: const EdgeInsets.only(top: 13),
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        _image == null
                            ? GestureDetector(

                            onTap: () {
                              _showPicker(context);
                            },
                            child: Padding(

                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  right: 20,
                                  left: 20,
                                  bottom: 10),

                              child: Image.asset('images/add.png'),
                            ))
                            : GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: GFAvatar(
                              size: 160,
                              backgroundImage: FileImage(
                                _image!,
                              ),
                              shape: GFAvatarShape.standard
                            // )
                            //                               CircleAvatar(
                            //                                   radius: width * 0.25,
                            //                                   backgroundColor: Colors.red,
                            //                                   backgroundImage: FileImage(
                            //                                     _image!,
                            //                                   ))),
                          ),
                        ),

                      ]),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(

                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TestPage()),
                        );
                        _formKey.currentState!.save();

                        // Perform your form submission here using _field1Value, _field2Value, _field3Value, and _dropdownValue
                      }
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext Index) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(children: [
                const Text(' Upload  Document',
                    textScaleFactor: 1.0, textAlign: TextAlign.start),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                      child: const SizedBox(
                        width: 60,
                        child: Wrap(
                          children: [
                            SizedBox(
                                width: 50,
                                child: Icon(Icons.camera_alt_outlined)),
                            Text('Camera')
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                      child: VerticalDivider(
                        thickness: 2,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        width: 70,
                        child: Wrap(
                          children: [
                            SizedBox(
                                width: 50,
                                child:
                                Image.asset('images/gallery.png')),
                            const Text('Gallery')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          );
        });
  }

  _imgFromCamera() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);

        final bytes = _image?.readAsBytesSync();
        selfiImgBase64 = base64Encode(bytes!);
      });
    }
  }

  _imgFromGallery() async {
    PickedFile? image = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
}
