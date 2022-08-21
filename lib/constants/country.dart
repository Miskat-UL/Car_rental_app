import 'dart:convert';

import 'package:car_rental_app/database/blog_database.dart';
import 'package:flutter/material.dart';

import '../models/blog_model.dart';

class CountryPicker extends StatefulWidget {
  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  List<Blogs>? blogs = [];
  bool _isLoading = false;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    BlogsDatabase.instance.close();
    super.dispose();
  }

  _loadData() async {
    setState(() {
      _isLoading = true;
    });
    blogs = await BlogsDatabase.instance.getAll();
    print(blogs);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('all blogs'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: blogs!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                      color: Color(0XFFc4e8c2),
                      margin: EdgeInsets.only(bottom: 13),
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 150,
                              color: Color.fromARGB(255, 255, 254, 254),
                              child: Image.memory(
                                base64Decode(blogs![index].image),
                                height: 100,
                                fit: BoxFit.contain,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(blogs![index].title),
                          Text(blogs![index].category),
                        ],
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



// ListView.builder(
//                 itemCount: blogs!.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     child: Container(
//                         height: 200,
//                         child: Column(
//                           children: [
//                             Image.memory(base64Decode(blogs![index].image)),
//                             Text(blogs![index].title),
//                             Text(blogs![index].category),
//                           ],
//                         )),
//                   );
//                 },
//               ),
