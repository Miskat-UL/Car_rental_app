import 'package:car_rental_app/database/database.dart';
import 'package:car_rental_app/models/cars.dart';
import 'package:car_rental_app/screens/carosul_ex.dart';
import 'package:car_rental_app/screens/home.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Car"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "Car Name",
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: _modelController,
            decoration: InputDecoration(
              labelText: "Car Model",
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: _imageController,
            decoration: InputDecoration(
              labelText: "Car image",
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: _detailsController,
            decoration: InputDecoration(
              labelText: "Car details",
              border: OutlineInputBorder(),
            ),
          ),
          TextButton(
            child: const Text("Add Car"),
            onPressed: () async{
              await CarsDatabse.instance.create(
                
                Cars(
                  name: _nameController.text,
                  model: _modelController.text,
                  image: _imageController.text,
                  details: _detailsController.text,
                ),
                // 'hello',
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
