import 'package:car_rental_app/database/database.dart';
import 'package:car_rental_app/models/cars.dart';
import 'package:car_rental_app/screens/user/home.dart';
import 'package:car_rental_app/screens/user/singleCar.dart';
import 'package:car_rental_app/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  List<Cars>? cars;
  bool isWaiting = false;
  final CarouselController _controller = CarouselController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    _refreshCars();
    super.initState();
  }

  @override
  void dispose() {
    CarsDatabse.instance.close();
    super.dispose();
  }

  _refreshCars() async {
    setState(() => isWaiting = true);

    cars = await CarsDatabse.instance.getAll();
    setState(() => isWaiting = false);
  }

  List categoryList = [
    Cars(
        id: 1,
        name: 'Homelander',
        model: 'Cruser',
        image: 'assets/1.png',
        details: 'white'),
    Cars(
        id: 1,
        name: 'Homelander',
        model: 'Cruser',
        image: 'assets/2.png',
        details: 'black'),
    Cars(
        id: 1,
        name: 'Homelander',
        model: 'Cruser',
        image: 'assets/1.png',
        details: 'gold'),
  ];
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) => GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              'No. ${imgList.indexOf(item)} image',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    return Scaffold(
      backgroundColor: Color(0XFFc4e8c2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://m.media-amazon.com/images/M/MV5BMDI2ZmQ2N2EtZTMwMC00YWVmLWEyMTMtNTZiMGEyNzNhMWM5XkEyXkFqcGdeQXZ3ZXNsZXk@._V1_.jpg',
                      ),
                    ),
                    Row(
                      children: [
                        const Text("INR 1434.21"),
                        IconButton(
                          onPressed: () async {
                            await Auth(auth: _auth).signOut();
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(children: [
                  Container(
                    child: CarouselSlider(
                      items: imageSliders,
                      carouselController: _controller,
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Weeding destination",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF46a094),
                          ),
                        ),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            // backgroundColor: Colors.amber,
                            textStyle: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_circle_right,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "See all",
                            style: TextStyle(
                              color: Color(0XFF46a094),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 340,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFF6bbd99),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 9.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Available Destination',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              'See our most viewed place',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: IconButton(
                          iconSize: 35,
                          icon: const Icon(
                            Icons.arrow_right_alt_rounded,
                            color: Color(0XFF6bbd99),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // SingleChildScrollView(
              //   child: Row(
              //     children: [
              //       SingleCars(
              //         picture: 'assets/1.png',
              //         title: 'Car 1',
              //         name: 'homelander',
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       SingleCars(
              //         picture: 'assets/1.png',
              //         title: 'Car 1',
              //         name: 'homelander',
              //       ),
              //     ],
              //   ),
              // ),
              isWaiting
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      height: 250,
                      child: ListView.builder(
                          itemCount: cars!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SingleCar(cars: cars![index])));
                              },
                              child: SingleCars(
                                name: cars![index].name,
                                picture: cars![index].image,
                                title: cars![index].model,
                              ),
                            );
                          }),
                    ),
              TextButton(onPressed: () async {}, child: Icon(Icons.add)),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleCars extends StatelessWidget {
  const SingleCars({
    Key? key,
    required this.name,
    required this.title,
    required this.picture,
  }) : super(key: key);
  final String name;
  final String title;
  final String picture;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 185,
      margin: const EdgeInsets.only(
        right: 10,
        top: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10, top: 10),
                  width: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFFc4e8c2),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Center(
                    child: Text(
                      'Booked',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Hero(tag: "carHero", child: Image.asset(picture)),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Descovery',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
