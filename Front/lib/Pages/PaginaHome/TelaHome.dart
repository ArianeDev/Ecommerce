import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arianeapp1/Components/CardLivro/CardLivro.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

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

              // 🎯 Banner Principal
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
                    Text(
                      "Encontre seu próximo",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "LIVRO FAVORITO",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // 🔍 Barra de busca
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

              // ⭐ Categorias
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Categorias",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(40, 40, 40, 1),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              SizedBox(
                height: 55,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20, right: 20),
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

              // 📚 Livros em destaque
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Destaques",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(40, 40, 40, 1),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 260,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  children: const [
                    // Cards do usuário
                    CardLivro(
                      nome: "O Senhor dos Anéis",
                      imagem: "assets/img/livro01.jpg",
                      preco: "59.90",
                      descricao: "Legal",
                    ),
                    SizedBox(width: 16),
                    CardLivro(
                      nome: "O Senhor dos Anéis",
                      imagem: "assets/img/livro01.jpg",
                      preco: "59.90",
                      descricao: "Legal",
                    ),
                    SizedBox(width: 16),
                    CardLivro(
                      nome: "O Senhor dos Anéis",
                      imagem: "assets/img/livro01.jpg",
                      preco: "59.90",
                      descricao: "Legal",
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // 🔧 Widget de categoria estilizado com gradiente + ícones
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
          Text(
            nome,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
