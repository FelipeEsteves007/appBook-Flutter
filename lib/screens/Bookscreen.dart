import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bookscreen extends StatefulWidget {
  const Bookscreen({super.key});

  @override
  State<Bookscreen> createState() => _BookscreenState();
}

class _BookscreenState extends State<Bookscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Books',
        ),
        backgroundColor: Color(0xFF021625),
      ),
      body: const Center(
       child: Text('Bem vindo'),
      )
    );
  }
}
