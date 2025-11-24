import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroLivro extends StatefulWidget {
  const CadastroLivro({super.key});

  @override
  State<CadastroLivro> createState() => _CadastroLivroState();
}

class _CadastroLivroState extends State<CadastroLivro> {
  final TextEditingController titulo = TextEditingController();
  final TextEditingController preco = TextEditingController();
  final TextEditingController descricao = TextEditingController();
  final TextEditingController foto = TextEditingController();

  Future<void> cadastrarLivro() async {
    try {
      await FirebaseFirestore.instance.collection("books").add({
        "nome": titulo.text,
        "preco": preco.text,
        "descricao": descricao.text,
        "foto": foto.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Livro cadastrado com sucesso!")),
      );

      titulo.clear();
      preco.clear();
      descricao.clear();
      foto.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao cadastrar livro: $e")),
      );
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
        body: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Cadastro de Livro",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextFormField(
                controller: titulo, 
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Digite o título do livro...',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextFormField(
                controller: preco, 
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Digite o preço do livro...',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextFormField(
                controller: descricao, 
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Digite a descrição do livro...',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextFormField(
                controller: foto, 
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Digite a URL da foto do livro...',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: cadastrarLivro, 
              child: Text("Cadastrar")
            )
          ],
        )
      ),
    );
  }
}