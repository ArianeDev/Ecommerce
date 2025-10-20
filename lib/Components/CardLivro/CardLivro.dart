import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arianeapp1/Pages/PaginaLivro/PaginaLivro.dart';

class CardLivro extends StatelessWidget {
  final String nome;
  final String imagem;
  final String preco;
  final String descricao;

  const CardLivro({
    super.key,
    required this.nome,
    required this.imagem,
    required this.preco,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaginaLivro(
              nome: nome, 
              imagem: imagem, 
              preco: "R\$ $preco",
              descricao: descricao,
            ),
          ),
        );
      },
      child: Container(
        width: 150,
        height: 200,
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
        child: Padding(
          padding: EdgeInsets.all(7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 80,
                child: Image.asset(
                  imagem,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10),
              Text(
                nome,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5),
              Text(
                preco,
                style: TextStyle(
                  fontSize: 13,
                ),
                textAlign: TextAlign.start,
              ),
            ] 
          ),
        ),
      ),
    );
  }
}