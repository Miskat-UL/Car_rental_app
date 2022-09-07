import 'package:car_rental_app/screens/user/home.dart';
import 'package:car_rental_app/screens/authentication/login.dart';
import 'package:car_rental_app/service/auth.dart';
import 'package:car_rental_app/service/userHelperDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.auth});
  final FirebaseAuth auth;
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  static const snackBarR = SnackBar(
    content: Text('Successfully registered!'),
  );
  String role = 'user';
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Color(0XFF46a094);
      }
      return Color(0XFF46a094);
    }

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
                'assets/6.svg',
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
                        hintText: 'Username',
                        focusColor: Color(0XFF46a094),
                        hintStyle: TextStyle(color: Color(0XFF46a094)),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        focusColor: Color(0XFF46a094),
                        hintStyle: TextStyle(color: Color(0XFF46a094)),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Color(0XFF46a094)),
                        focusColor: Color(0XFF46a094),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            'SignUp As Admin? ',
                            style: TextStyle(
                              color: Color(0XFF46a094),
                            ),
                          ),
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                                role = 'admin';
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0XFF6bbd99),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                          onPressed: () async {
                            String res =
                                await Auth(auth: widget.auth).createAccount(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            if (res == "success") {
                              _emailController.clear();
                              _passwordController.clear();
                              UserHelper.saveUser(
                                  widget.auth.currentUser, role);
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackBarR,
                              );
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => Login(
                                    auth: widget.auth,
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Register',
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
                    'Already have an account?',
                    style: TextStyle(color: Color(0XFF46a094)),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => Register(
                                    
                                  )),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Color(0XFF46a094)),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
