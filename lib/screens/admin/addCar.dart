import 'dart:convert';
import 'dart:typed_data';

import 'package:car_rental_app/database/database.dart';
import 'package:car_rental_app/models/cars.dart';
import 'package:car_rental_app/service/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/utilities.dart';

class AddCars extends StatefulWidget {
  const AddCars({super.key});

  @override
  State<AddCars> createState() => _AddCarsState();
}

class _AddCarsState extends State<AddCars> {
  // String? image;
  Uint8List? imageFile;
  final ImagePicker _imagePickeer = ImagePicker();

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print("no image selected");
  }

  void pickImageFromGallery() async {
    Uint8List imgFile = await pickImage(ImageSource.gallery);
    // String imgString = Utility.base64String(await imageFile!.readAsBytes());
    setState(() {
      imageFile = imgFile;
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  static const snackBarR = SnackBar(
    content: Text('Car Added'),
  );
  static const snackBarE = SnackBar(
    content: Text('Error Occured'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFc4e8c2),
        centerTitle: true,
        title: const Text("Add Car"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  imageFile != null
                      ? CircleAvatar(
                          foregroundColor: Colors.black,
                          // backgroundImage:
                          //     MemoryImage(Utf8Encoder().convert(image!)),
                          backgroundImage: MemoryImage(imageFile!),
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
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0XFF46a094),
                      width: 2,
                    ),
                  ),
                  labelText: "Car Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _modelController,
                decoration: const InputDecoration(
                  labelText: "Car Model",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0XFF46a094),
                      width: 2,
                    ),
                  ),
                  // enabledBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //     color: Color(0XFF46a094),
                  //     width: 2,
                  //   ),
                  // ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _imageController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0XFF46a094),
                      width: 2,
                    ),
                  ),
                  labelText: "Price per hour",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _detailsController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0XFF46a094),
                      width: 2,
                    ),
                  ),
                  labelText: "Car details",
                  // labelStyle: ,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 30),
                decoration: BoxDecoration(
                  color: const Color(0XFF6bbd99),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  child: const Text(
                    "Add Car",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    // await CarsDatabse.instance.create(
                    //   Cars(
                    //     name: _nameController.text,
                    //     model: _modelController.text,
                    //     image: _imageController.text,
                    //     details: _detailsController.text,
                    //   ),
                    String res = await FirebaseServices().uploadCars(
                      _nameController.text,
                      _modelController.text,
                      imageFile,
                      _detailsController.text,
                    );
                    if (res == "success") {
                      ScaffoldMessenger.of(context).showSnackBar(snackBarR);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(snackBarR);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
