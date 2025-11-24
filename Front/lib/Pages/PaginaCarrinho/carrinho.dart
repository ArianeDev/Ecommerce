import 'package:arianeapp1/Service/carrinho_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaCarrinho extends StatefulWidget {
  const TelaCarrinho({super.key});

  @override
  State<TelaCarrinho> createState() => _TelaCarrinhoState();
}

class _TelaCarrinhoState extends State<TelaCarrinho> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        body: carrinho.itens.isEmpty
          ? Center(
            child: Text(
              "Carrinho vazio",
              style: TextStyle(fontSize: 18),
            ),
          ) : ListView.builder(
          itemCount: carrinho.itens.length,
          itemBuilder: (context, index) {
          final item = carrinho.itens[index];
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Image.asset(item.livro.foto, width: 50),
                title: Text(item.livro.titulo),
                subtitle: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          carrinho.atualizarQuantidade(
                              item.livro, item.quantidade - 1);
                        });
                      },
                    ),
                    Text("${item.quantidade}"),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          carrinho.atualizarQuantidade(
                              item.livro, item.quantidade + 1);
                        });
                      },
                    ),
                  ],
                ),
                trailing: Text("R\$ ${item.livro.preco}"),
              ))
            ); 
          },
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "R\$ ${carrinho.total.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ),
      ),
    );
  }
}