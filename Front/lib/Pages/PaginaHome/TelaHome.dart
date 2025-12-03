import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

  Future<List<dynamic>> listarSugestoesDiversas() async {
  final termos = ["romance", "fantasia", "classicos", "ficcao"];
  List<dynamic> todosLivros = [];

  for (var termo in termos) {
    final url = Uri.parse("https://openlibrary.org/search.json?q=$termo");
    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      final dados = jsonDecode(resposta.body);
      final livros = dados["docs"];
      todosLivros.addAll(livros.take(2)); 
    }
  }

  return todosLivros.take(8).toList(); 
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: const Color.fromRGBO(79, 55, 139, 1),
      ),
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(79, 55, 139, 1),
          title: Text(
            "AriBooks",
            style: GoogleFonts.zenDots(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔹 Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(79, 55, 139, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Encontre seu próximo",
                        style: TextStyle(color: Colors.white70, fontSize: 18)),
                    Text("LIVRO FAVORITO",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Buscar livros...",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // 🔹 Categorias
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Categorias",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(40, 40, 40, 1))),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 55,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    categoria("Ficção", Icons.auto_stories),
                    categoria("Romance", Icons.favorite),
                    categoria("Fantasia", Icons.auto_awesome),
                    categoria("Suspense", Icons.visibility),
                    categoria("HQs", Icons.menu_book),
                    categoria("Clássicos", Icons.history_edu),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              // 🔹 Sugestão de leitura (API)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Sugestão de leitura",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(40, 40, 40, 1))),
              ),
              const SizedBox(height: 15),

              FutureBuilder<List<dynamic>>(
                future: listarSugestoesDiversas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Erro ao carregar sugestões",
                            style: TextStyle(color: Colors.red)));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Nenhum livro encontrado"));
                  }

                  final livros = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: livros.length,
                    itemBuilder: (context, index) {
                      final livro = livros[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: const Icon(Icons.menu_book,
                                color: Color.fromRGBO(79, 55, 139, 1)),
                            title: Text(
                              livro["title"] ?? "Sem título",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              "Autor: ${(livro["author_name"] != null) ? livro["author_name"].join(", ") : "Desconhecido"}",
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                            trailing: Text(
                              "Ano: ${livro["first_publish_year"] ?? "--"}",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoria(String nome, IconData icone) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(120, 88, 190, 1),
            Color.fromRGBO(79, 55, 139, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icone, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(nome,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15)),
        ],
      ),
    );
  }
}
