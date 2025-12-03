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
        backgroundColor: const Color.fromRGBO(233, 233, 233, 1),
        appBar: AppBar(
          title: Text(
            "AriBooks",
            style: GoogleFonts.zenDots(),
          ),
          foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: const Color.fromRGBO(15, 0, 68, 1),
        ),
        body: carrinho.itens.isEmpty
            ? const Center(
                child: Text(
                  "Carrinho vazio",
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: carrinho.itens.length,
                itemBuilder: (context, index) {
                  final item = carrinho.itens[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: Image.asset(item.livro.foto, width: 50),
                        title: Text(item.livro.titulo),
                        subtitle: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  carrinho.atualizarQuantidade(
                                      item.livro, item.quantidade - 1);
                                });
                              },
                            ),
                            Text("${item.quantidade}"),
                            IconButton(
                              icon: const Icon(Icons.add),
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
                      ),
                    ),
                  );
                },
              ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "R\$ ${carrinho.total.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(15, 0, 68, 1),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                  label: const Text(
                    "Finalizar Compra",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      carrinho.limpar(); // remove todos os itens
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Compra realizada com sucesso!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
