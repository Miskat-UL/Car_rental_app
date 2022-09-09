import 'dart:typed_data';

import 'package:car_rental_app/models/cars.dart';
import 'package:car_rental_app/service/storage.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadCars(
    String name,
    String model,
    Uint8List? image,
    String details,
  ) async {
    String res = 'Error';
    try {
      String photoUrl = await Storage().uploadImage("cars", image!, true);
      String carsId = const Uuid().v1();
      Cars cars =
          Cars(name: name, model: model, image: photoUrl, details: details);

      _firestore.collection('cars').doc(carsId).set(cars.toJson());
      res = "success";
      return res;
    } catch (e) {
      return e.toString();
    }
  }
}
