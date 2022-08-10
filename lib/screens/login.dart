import 'package:car_rental_app/screens/home.dart';
import 'package:car_rental_app/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFc4e8c2),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: SvgPicture.asset(
                'assets/4.svg',
                height: 350,
                width: 350,
              ),
            ),
            Expanded(
              flex: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        focusColor: Color(0XFF46a094),
                        hintStyle: TextStyle(color: Color(0XFF46a094)),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Color(0XFF46a094)),
                        focusColor: Color(0XFF46a094),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 5),
                      decoration: BoxDecoration(
                        color: Color(0XFF6bbd99),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()),
                            );
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Color(0XFF46a094)),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const Register()),
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Color(0XFF46a094)),
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}