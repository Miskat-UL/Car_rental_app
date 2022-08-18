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
  late DBHelper dbHelper;
  late List<Blog> blogs;
  XFile? imgFile;
  final ImagePicker _imagePickeer = ImagePicker();

  void pickImageFromGallery() async {
    imgFile = await _imagePickeer.pickImage(source: ImageSource.gallery);
    String imgString = Utility.base64String(await imgFile!.readAsBytes());
    setState(() {
      // List<int> list = utf8.encode(imgString);
      // Uint8List bytes = Uint8List.fromList(list);
      image = imgString;
    });
    print(imgString);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
      ),
      body: Column(
        children: [
          IconButton(onPressed: pickImageFromGallery, icon: Icon(Icons.image)),
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
                children: const [
                  TextField(
                    decoration: InputDecoration(
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
                  TextField(),
                  TextField(),
                  TextField(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
