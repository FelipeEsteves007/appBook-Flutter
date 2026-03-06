import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste/screens/Bookscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF021625);
    const Color gold = Color(0xFFD4AF37);
    const Color gray = Color(0xFF455A64);
    return Scaffold(
      body: Container(
        width: 500,
        height: 1000,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF021625), gray])
        ),
        child: SafeArea(
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.book_outlined,
                    size: 80,
                    color: gold,
                  ),
                  const SizedBox(height: 10),
                  Text('Search Your Book',
                  style: GoogleFonts.bebasNeue(
                    color: gold,
                    fontSize: 40,
                    letterSpacing: 2)
                  ),
                  const SizedBox(height:10),
                  TextFormField(
                    controller: _userController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      label: Text(
                        'User ou E-mail',
                        style: TextStyle(
                          color: gold
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: gray)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: gold)
                      )
                    ),
                  ),
                  const SizedBox(height:10),
                  const SizedBox(height:10),
                  TextFormField(
                    controller: _passController,
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                        label: Text(
                          'Password',
                          style: TextStyle(
                              color: gold
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: gray)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: gold)
                        )
                    ),
                  ),
                  const SizedBox(height:10),
                  ElevatedButton(
                      onPressed: () {
                        String user = _userController.text;
                        String pass = _passController.text;
                        final rule = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).+$');
                        
                        if (user.isNotEmpty && rule.hasMatch(pass)) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Bookscreen()));  
                        }
                        else if (user.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Invalid user!'),
                            backgroundColor: Colors.red
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Invalid password! Use letters, numbers, and symbols.'),
                                backgroundColor: Colors.red
                            ),
                          );
                        }
                  }, style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    backgroundColor: gold,
                    foregroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12)
                    )
                  ), child: Text(
                    'Login',
                        style: GoogleFonts.robotoFlex(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        ),
                  ))
                ],
              ),
            ),
        ),
      ),
    );
  }
}