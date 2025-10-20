import 'dart:async';

import 'package:arianeapp1/Pages/Login/login.dart';
import 'package:arianeapp1/Pages/PaginaLivros/PaginaLivros.dart';
import 'package:arianeapp1/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arianeapp1/main.dart';
import 'Components/Contador/Contador.dart';
import 'package:arianeapp1/Components/CardLivro/CardLivro.dart';
import 'package:arianeapp1/Pages/PaginaHome/TelaHome.dart';
import 'package:arianeapp1/Pages/PaginaLivro/PaginaLivro.dart';
import 'package:arianeapp1/Pages/Login/login.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    )
  );
}

// ful - estática
// less - dinâmica
// Scaffold - separação dos componentes
// Widgets nativo
// Imagem.network() - pegar imagem da internet

// Tela que aparece primeiro com a logo
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => MyApp()
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 0, 68, 1),
      body: Center(
        child: Text(
          "AriBooks",
          style: GoogleFonts.zenDots(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

// Boa prática - colocar a lógica antes do segundo @override
class _NavBarState extends State<NavBar> {
  int currentIndex = 0; // variável que indica posição do index
  
  void changeIndex(int index) {
    setState(() { // permite alterar o valor de variáveis
      currentIndex = index;
    });
  }

  List<Widget> screens = [
    TelaHome(),
    TelaLivros(),
    TelaUser(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: screens.elementAt(currentIndex), // o conteúdo da teça será o index selecionado
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Livros",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              label: "Sair",
            )
          ],
          currentIndex: currentIndex,
          onTap: changeIndex,
        ),
      ),
    );
  }
}