import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:car_rental_app/database/blog_database.dart';
import 'package:car_rental_app/models/blog_model.dart';
import 'package:car_rental_app/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/utilities.dart';

class BlogUi extends StatefulWidget {
  const BlogUi({super.key});

  @override
  State<BlogUi> createState() => _BlogUiState();
}

class _BlogUiState extends State<BlogUi> {
  late Future<File> imageFile;
  // Uint8List? image;
  String? image;
  // late DBHelper dbHelper;
  // late List<Blog> blogs;
  XFile? imgFile;
  final ImagePicker _imagePickeer = ImagePicker();
  List<String> _countryList = [
    'sundarban',
    'dhaka',
    'chittagong',
    'rajshahi',
    'rangpur',
    'barisal',
    'khulna',
    'sylhet'
  ];
  String dropdownValue = 'dhaka';
  bool _isLoading = false;
  void pickImageFromGallery() async {
    imgFile = await _imagePickeer.pickImage(source: ImageSource.gallery);
    String imgString = Utility.base64String(await imgFile!.readAsBytes());
    setState(() {
      // List<int> list = utf8.encode(imgString);
      // Uint8List bytes = Uint8List.fromList(list);
      image = imgString;
    });
    // print(imgString);
    // .then((imgFile) {
    //   String imgString = Utility.base64String(imgFile.readAsBytesSync());
    //   Blog photo = Blog(id:0, photoName:imgString);
    //   dbHelper.save(photo);
    // });
  }

  // void imagePicker() async {
  //   Uint8List imgU = await pickImage(ImageSource.gallery);
  //   // String img = Utf8Decoder().convert(imgU);
  //   setState(() {
  //     image = imgU;
  //   });
  //   // var a = Utility.base64String(imgU.readAsBytesSync());
  //   // print(a);
  // }
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  _postToDatabase() async {
    setState(() {
      _isLoading = true;
    });
    await BlogsDatabase.instance.create(Blogs(
      title: _titleController.text,
      body: _descriptionController.text,
      location: _countryController.text,
      category: _categoryController.text,
      image: image!,
    ));
    _titleController.clear();
    _descriptionController.clear();
    _countryController.clear();
    _categoryController.clear();
    image = null;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF46a094),
        title: const Text('Blog'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              image != null
                  ? CircleAvatar(
                      foregroundColor: Colors.black,
                      // backgroundImage:
                      //     MemoryImage(Utf8Encoder().convert(image!)),
                      backgroundImage: MemoryImage(base64Decode(image!)),
                      backgroundColor: Colors.transparent,
                      // child: Image.asset('assets/1.png'),
                      radius: 100,
                    )
                  : CircleAvatar(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.transparent,
                      child: Image.asset('assets/1.png'),
                      radius: 100,
                    ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  onPressed: pickImageFromGallery,
                  icon: const Icon(Icons.add_a_photo),
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFF46a094),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Category (i.e: hiking,beach,...)',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFF46a094),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text('Location: '),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 100,
                        child: DropdownButton(
                          value: dropdownValue,
                          onChanged: (value) {
                            setState(() {
                              dropdownValue = value.toString();
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_downward,
                            color: Color(0XFF46a094),
                          ),
                          elevation: 16,
                          style: const TextStyle(color: Color(0XFF46a094)),
                          underline: Container(
                            height: 2,
                            color: const Color(0XFF46a094),
                          ),
                          items: _countryList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: 150,
                      child: TextField(
                        controller: _descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0XFF46a094),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: _postToDatabase,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Post'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
