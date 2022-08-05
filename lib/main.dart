import 'package:car_rental_app/database/database.dart';
import 'package:car_rental_app/models/cars.dart';
import 'package:car_rental_app/screens/home.dart';
import 'package:car_rental_app/screens/singleCar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
