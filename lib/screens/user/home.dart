import 'package:car_rental_app/constants/country.dart';
import 'package:car_rental_app/screens/admin/addCar.dart';
import 'package:car_rental_app/screens/user/blog_page.dart';
import 'package:car_rental_app/screens/user/carosul_ex.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.auth});
  final FirebaseAuth auth;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void pageChanger(int page) {
    _pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          CarouselWithIndicatorDemo(),
          const AddCars(),
          const BlogUi(),
          CountryPicker(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0XFFc4e8c2),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.black),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_outlined, color: Colors.black),
            label: 'add blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode, color: Colors.black),
            label: 'blogs',
          ),
        ],
        onTap: pageChanger,
      ),
    );
  }
}
