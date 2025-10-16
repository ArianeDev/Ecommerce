import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Components/Contador/Contador.dart';
import '../../user.dart';

class PaginaLivro extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nome),
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
                    imagem,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nome,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Preço: R\$ $preco',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Quantidade:"),
                      Contador(), 
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
                    descricao,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TelaUser()));
              }, 
              child: Icon(Icons.play_arrow)
            )
          ],
        ),
      ),
    );
  }
}