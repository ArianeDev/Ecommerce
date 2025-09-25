import 'package:flutter/material.dart';

void main() {
  runApp(const TelaHome());
}

// ful - estática
// less - dinâmica
// Scaffold - separação dos componentes
// Widgets nativo

class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int numero = 1;

  void aumentar() {
    setState(() {
      numero++;
    });
  }
  void diminuir() {
    setState(() {
      if (numero > 1 ) {
        numero--;
      }
    });
  }
  void resetar() {
    setState(() {
      numero = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      aumentar();
                    }, 
                    child: Text("+"),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "$numero",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: (){
                      diminuir();
                    }, 
                    child: Text("-"),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: (){
                  resetar();
                }, 
                child: Text("Resetar"),
              )
            ],
          ),
        )
      ],
    );
  }
}

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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,  
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
    );
  }
}

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
                      Container(
                        width: 300,
                        height: 100,
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
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Selecione a quantidade de livros que deseja: "),
            Contador(), 
          ],
        ),
      ),
    );
  }
}

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> todosLivros = [
    {
      "nome": "O verão que mudou minha vida",
      "imagem": "assets/livro01.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "A selação",
      "imagem": "assets/livro02.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "O verão que mudou minha vida",
      "imagem": "assets/livro01.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "A selação",
      "imagem": "assets/livro02.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "O verão que mudou minha vida",
      "imagem": "assets/livro01.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "A selação",
      "imagem": "assets/livro02.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "O verão que mudou minha vida",
      "imagem": "assets/livro01.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "A selação",
      "imagem": "assets/livro02.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "O verão que mudou minha vida",
      "imagem": "assets/livro01.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "A selação",
      "imagem": "assets/livro02.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "O verão que mudou minha vida",
      "imagem": "assets/livro01.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "A selação",
      "imagem": "assets/livro02.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "O verão que mudou minha vida",
      "imagem": "assets/livro01.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "A selação",
      "imagem": "assets/livro02.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "O verão que mudou minha vida",
      "imagem": "assets/livro01.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
    {
      "nome": "A selação",
      "imagem": "assets/livro02.jpg",
      "preco": "R\$ 10,00",
      "descricao": "Muito bom viu, pode ler"
    },
  ];

  List<Map<String, String>> livrosFiltrados = [];

  @override
  void initState() { // iniciar variáveis, configurar controladores, carregar dados ou preparar estados iniciais
    super.initState();
    livrosFiltrados = List.from(todosLivros);
  }

  void _filtrarLivros(String texto) {
    setState(() {
      livrosFiltrados = todosLivros.where((livro) {
        final nome = livro["nome"]!.toLowerCase();
        return nome.contains(texto.toLowerCase());
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp( // fornece os componentes
      home: Scaffold( // separa as telas
        backgroundColor: Color.fromRGBO(233, 233, 233, 1),
        appBar: AppBar( // barra superior
          title: Text("Livros"),
          foregroundColor: Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Color.fromRGBO(15, 0, 68, 1),
        ),
        body: SingleChildScrollView(
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
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 12)
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: livrosFiltrados.map((livro) {
                      return CardLivro(
                        nome: livro["nome"]!, 
                        imagem: livro["imagem"]!, 
                        preco: livro["preco"]!, 
                        descricao: livro["descricao"]!
                      );
                    }).toList(),
                  )
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     CardLivro(
                  //       nome: "O verão que mudou minha vida", 
                  //       imagem: "assets/livro01.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     ),
                  //     CardLivro(
                  //       nome: "A seleção", 
                  //       imagem: "assets/livro02.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     ),
                  //     CardLivro(
                  //       nome: "O verão que mudou minha vida", 
                  //       imagem: "assets/livro01.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     )
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     CardLivro(
                  //       nome: "O verão que mudou minha vida", 
                  //       imagem: "assets/livro01.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     ),
                  //     CardLivro(
                  //       nome: "A seleção", 
                  //       imagem: "assets/livro02.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     ),
                  //     CardLivro(
                  //       nome: "O verão que mudou minha vida", 
                  //       imagem: "assets/livro01.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     )
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     CardLivro(
                  //       nome: "O verão que mudou minha vida", 
                  //       imagem: "assets/livro01.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     ),
                  //     CardLivro(
                  //       nome: "A seleção", 
                  //       imagem: "assets/livro02.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     ),
                  //     CardLivro(
                  //       nome: "O verão que mudou minha vida", 
                  //       imagem: "assets/livro01.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     )
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     CardLivro(
                  //       nome: "O verão que mudou minha vida", 
                  //       imagem: "assets/livro01.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     ),
                  //     CardLivro(
                  //       nome: "A seleção", 
                  //       imagem: "assets/livro02.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     ),
                  //     CardLivro(
                  //       nome: "O verão que mudou minha vida", 
                  //       imagem: "assets/livro01.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     )
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     CardLivro(
                  //       nome: "O verão que mudou minha vida", 
                  //       imagem: "assets/livro01.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     ),
                  //     CardLivro(
                  //       nome: "A seleção", 
                  //       imagem: "assets/livro02.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     ),
                  //     CardLivro(
                  //       nome: "O verão que mudou minha vida", 
                  //       imagem: "assets/livro01.jpg", 
                  //       preco: "R\$ 10,00", 
                  //       descricao: "Muito legal"
                  //     )
                  //   ],
                  // ),
                ],
              ),  
            ), 
          ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Livros",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              label: "Sair",
            )
          ]
        ), 
      ),
    );
  }
}