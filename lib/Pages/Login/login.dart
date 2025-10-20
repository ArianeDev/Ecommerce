import 'package:arianeapp1/Pages/PaginaLivros/PaginaLivros.dart';
import 'package:arianeapp1/main.dart';
import 'package:arianeapp1/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // variável que observa o que o usuário está digitando
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();

  String correctUser = 'Ariane';
  String correctPass = '123';

  String mensage = "";

  void login() {
    if (user.text == correctUser && password.text == correctPass) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));

      setState(() {
        mensage = "";
      });
    } else {
      setState(() {
        mensage = "Existe credenciais incorretas";
      });
    }
  }

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
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 40,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ]
                    )
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: TextFormField(
                      controller: user, // variável que armazena o valor digitado
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Digite seu usuário...',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: TextFormField(
                      controller: password, // variável que armazena o valor digitado
                      obscureText: true, // privar caracteres
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Digite sua senha...',
                      ),
                    ),
                  ),
                  Visibility(
                    visible: mensage.isNotEmpty,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(122, 0, 0, 0.1),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text(
                        "$mensage",
                        style: TextStyle(
                          color: Color.fromRGBO(122, 0, 0, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: login, 
                    child: Text(
                      "Login"
                    )
                  )
                ]
              ), 
            ),
          ) 
        ),
      ),
    );
  }
}