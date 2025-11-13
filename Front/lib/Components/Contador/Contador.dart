import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int numero = 1;

  void aumentar() {
    setState(() {
      numero++;
    });
  }
  void diminuir() {
    setState(() {
      if (numero > 1 ) {
        numero--;
      }
    });
  }
  void resetar() {
    setState(() {
      numero = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: (){
                      diminuir();
                    }, 
                    child: Text("-"),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "$numero",
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: (){
                      aumentar();
                    }, 
                    child: Text("+"),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}