import 'package:car_rental_app/firebase_options.dart';
import 'package:car_rental_app/screens/admin/addCar.dart';
import 'package:car_rental_app/screens/admin/admin_home.dart';
import 'package:car_rental_app/screens/user/home.dart';
import 'package:car_rental_app/screens/authentication/login.dart';
import 'package:car_rental_app/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
      home: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return const Root();
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0XFF46a094),
              ),
            );
          }
        },
      ),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth(auth: _auth).user,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            
            if (snapshot.data?.uid == null) {
              return Login(auth: _auth);
            }
            return StreamBuilder(
              stream: _firestore
                  .collection('users')
                  .doc(snapshot.data!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) { 
                if (snapshot.hasData && snapshot.data != null) {
                  final user = snapshot.data!;
                  // print(user['role']);
                  if (user['role'] == 'admin') {
                    return const AdminHome();
                  } else {
                    return MyHomePage(auth: _auth); 
                  }
                }
                return const Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
              },
            );
          }
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        });
  }
}
