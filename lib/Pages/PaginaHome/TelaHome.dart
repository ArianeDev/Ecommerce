import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arianeapp1/Components/CardLivro/CardLivro.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(233, 233, 233, 1),
        appBar: AppBar(
          title: Text(
            "AriBooks",
            style: GoogleFonts.zenDots(),
          ),
          foregroundColor: Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Color.fromRGBO(15, 0, 68, 1),
        ),
      ),
    );
  }
}