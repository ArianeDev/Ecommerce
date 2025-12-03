import 'package:arianeapp1/Models/Carrinho.dart';
import 'package:arianeapp1/Models/Livro.dart';
import 'package:arianeapp1/Pages/PaginaCarrinho/carrinho.dart';
import 'package:arianeapp1/Service/carrinho_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Components/Contador/Contador.dart';
import '../../user.dart';

class PaginaLivro extends StatefulWidget {
  final String nome;
  final String imagem;
  final String preco;
  final String descricao;

  const PaginaLivro({
    super.key,
    required this.nome,
    required this.imagem,
    required this.preco,
    required this.descricao,
  });

  @override
  PaginaLivroState createState() => PaginaLivroState();
}

class PaginaLivroState extends State<PaginaLivro> {
  int quantidade = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.nome,
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        widget.imagem,
                        width: 150,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.nome,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'R\$ ${widget.preco}',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Quantidade:",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          Contador(
                            onQuantityChanged: (valor) {
                              setState(() {
                                quantidade = valor;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Descrição",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                widget.descricao,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final livro = Livro(
                    titulo: widget.nome,
                    foto: widget.imagem,
                    preco: widget.preco,
                    descricao: widget.descricao,
                  );

                  final item = ItemCarrinho(
                    livro: livro,
                    quantidade: quantidade,
                  );

                  carrinho.adicionar(item);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Livro adicionado ao carrinho!'),
                      backgroundColor: Colors.green[700],
                    ),
                  );
                },
                icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                label: Text(
                  "Adicionar ao Carrinho",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}