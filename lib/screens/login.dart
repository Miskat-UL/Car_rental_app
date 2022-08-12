import 'package:car_rental_app/screens/home.dart';
import 'package:car_rental_app/screens/register.dart';
import 'package:car_rental_app/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.auth});
  final FirebaseAuth auth;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  static const snackBarR = SnackBar(
    content: Text('Successful Login!'),
  );
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
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        focusColor: Color(0XFF46a094),
                        hintStyle: TextStyle(color: Color(0XFF46a094)),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
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
                          onPressed: () async {
                            String res = await Auth(auth: widget.auth).signIn(
                                email: _emailController.text,
                                password: _passwordController.text);
                            if (res == "success") {
                              _emailController.clear();
                              _passwordController.clear();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBarR);
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (_) => MyHomePage(auth: widget.auth),
                              ));
                            }
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
                                builder: (context) => Register(
                                      auth: widget.auth,
                                    )),
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
