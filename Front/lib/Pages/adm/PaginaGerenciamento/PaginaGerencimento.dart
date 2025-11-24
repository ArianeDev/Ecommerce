import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GerenciarLivros extends StatelessWidget {
  const GerenciarLivros({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gerenciar Livros")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("books").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final livros = snapshot.data!.docs;

          return ListView.builder(
            itemCount: livros.length,
            itemBuilder: (context, index) {
              final doc = livros[index];
              final data = doc.data() as Map<String, dynamic>;

              return Card(
                child: ListTile(
                  leading: data["foto"] != null
                      ? Image.asset(data["foto"], width: 50, fit: BoxFit.cover)
                      : Icon(Icons.book),
                  title: Text(data["nome"] ?? "Sem título"),
                  subtitle: Text("Preço: R\$ ${data["preco"]}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _editarLivro(context, doc.id, data);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          FirebaseFirestore.instance.collection("books").doc(doc.id).delete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _editarLivro(BuildContext context, String docId, Map<String, dynamic> data) {
    TextEditingController nomeController = TextEditingController(text: data["nome"]);
    TextEditingController precoController = TextEditingController(text: data["preco"].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Editar Livro"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nomeController, decoration: InputDecoration(labelText: "Nome")),
            TextField(controller: precoController, decoration: InputDecoration(labelText: "Preço")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection("books").doc(docId).update({
                "nome": nomeController.text,
                "preco": double.tryParse(precoController.text) ?? data["preco"],
              });
              Navigator.pop(context);
            },
            child: Text("Salvar"),
          ),
        ],
      ),
    );
  }
}
