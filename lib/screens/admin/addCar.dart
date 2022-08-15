import 'package:car_rental_app/database/database.dart';
import 'package:car_rental_app/models/cars.dart';
import 'package:car_rental_app/screens/user/carosul_ex.dart';
import 'package:car_rental_app/screens/user/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';

class AddCars extends StatefulWidget {
  const AddCars({super.key});

  @override
  State<AddCars> createState() => _AddCarsState();
}

class _AddCarsState extends State<AddCars> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  static const snackBarR = SnackBar(
    content: Text('Car Added'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFc4e8c2),
        centerTitle: true,
        title: const Text("Add Car"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                labelText: "Car image",
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
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 30),
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
                  await CarsDatabse.instance.create(
                    Cars(
                      name: _nameController.text,
                      model: _modelController.text,
                      image: _imageController.text,
                      details: _detailsController.text,
                    ),
                    // 'hello',
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBarR);
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
