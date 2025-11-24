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
    required this.descricao
  });

  @override
  PaginaLivroState createState() => PaginaLivroState();
}

class PaginaLivroState extends State<PaginaLivro> {
  int quantidade = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    widget.imagem,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nome,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Preço: R\$ ${widget.preco}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Quantidade:"),
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
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(221, 218, 218, 218),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.descricao,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                final livro = Livro(
                  titulo: widget.nome,
                  foto: widget.imagem,
                  preco: widget.preco,
                  descricao: widget.descricao,
                );

                final item = ItemCarrinho(
                  livro: livro, 
                  quantidade: quantidade
                );

                carrinho.adicionar(item);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Livro adicionado ao carrinho!'),
                  ),
                );
              }, 
              child: Icon(Icons.add_shopping_cart)
            )
          ],
        ),
      ),
    );
  }
}