import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arianeapp1/Components/CardLivro/CardLivro.dart';
import 'package:http/http.dart' as http;

class TelaLivros extends StatefulWidget {
  const TelaLivros({super.key});

  @override
  State<TelaLivros> createState() => _TelaLivrosState();
}

class _TelaLivrosState extends State<TelaLivros> {
  String? API;
  TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> livrosFiltrados = [];
  List<Map<String, dynamic>> getLivros = [];

  @override
  void initState() { // iniciar variáveis, configurar controladores, carregar dados ou preparar estados iniciais
    super.initState();
    listarLivros();
    livrosFiltrados = List.from(getLivros);
  }

  Future<void> listarLivros() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("books").get();

      setState(() {
        getLivros = snapshot.docs.map((doc) {
          return {
            "nome": doc["nome"],
            "imagem": doc["foto"],
            "preco": doc["preco"],
            "descricao": doc["descricao"],
          };
        }).toList();
        
        
        livrosFiltrados = List<Map<String, dynamic>>.from(getLivros.map((livro) {
          return {
            "nome": livro["nome"].toString(),
            "imagem": livro["imagem"].toString(),
            "preco": livro["preco"].toString(),
            "descricao": livro["descricao"].toString(),
          };
        }));

        API = "ok";
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao cadastrar livro: $e")),
      );
    }
  } 

  void _filtrarLivros(String texto) {
    setState(() {
      livrosFiltrados = getLivros.where((livro) {
        final nome = livro["nome"]!.toLowerCase();
        return nome.contains(texto.toLowerCase());
      }).map((livro) => {
        "nome": livro["nome"]!,
        "imagem": livro["imagem"]!,
        "preco": livro["preco"]!,
        "descricao": livro["descricao"]!
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // fornece os componentes
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: Scaffold( // separa as telas
        backgroundColor: Color.fromRGBO(233, 233, 233, 1),
        appBar: AppBar( // barra superior
          title: Text(
            "AriBooks",
            style: GoogleFonts.zenDots(),
          ),
          foregroundColor: Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Color.fromRGBO(15, 0, 68, 1),
        ),
        body: API == null ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.end, mexer no eixo x da coluna
                children: [ // widgets filhos
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            )
                          ]
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: _filtrarLivros,
                          decoration: InputDecoration(
                            hintText: "Pesquisar Livros...",
                            prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 12)
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: livrosFiltrados.length,
                    itemBuilder: (context, index) {
                      final livro = livrosFiltrados[index];
                      return CardLivro(
                        nome: livro["nome"]!,
                        imagem: livro["imagem"]!,
                        preco: livro["preco"]!,
                        descricao: livro["descricao"]!,
                      );
                    },
                  ),
                ],
              ),  
            ), 
          ), 
      ),
    );
  }
}