import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arianeapp1/Components/CardLivro/CardLivro.dart';
import 'package:http/http.dart' as http;

class TelaLivros extends StatefulWidget {
  const TelaLivros({super.key});

  @override
  State<TelaLivros> createState() => _TelaLivrosState();
}

class _TelaLivrosState extends State<TelaLivros> {
  String? API;
  TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> todosLivros = [
    {
      "nome": "Eu sempre morro",
      "imagem": "assets/img/livro16.jpg",
      "preco": "R\$ 39,90",
      "descricao": "Eu Sempre Morro é uma obra poética e sensível que mergulha nas profundezas dos sentimentos humanos. Com uma estrutura inovadora que mistura minicontos e prosas poéticas, o livro apresenta personagens antropomórficos que vivenciam temas como ausência, solidão, saudade e desencontros amorosos."
    },
    {
      "nome": "Tudo o que eu gostaria de ter dito",
      "imagem": "assets/img/livro15.jpg",
      "preco": "R\$ 57,90",
      "descricao": "Essa obra é uma coletânea de poesias que mergulha nas emoções humanas com delicadeza e profundidade. Paôla Lucas, com sua escrita sensível e acessível, convida o leitor a refletir sobre os ciclos da vida, os medos contemporâneos e a força dos recomeços."
    },
    {
      "nome": "Academia dos casos arquivados",
      "imagem": "assets/img/livro14.jpg",
      "preco": "R\$ 42,09",
      "descricao": "Cassie, uma jovem com o dom de ler pessoas, é recrutada pelo FBI para um programa secreto que reúne adolescentes com habilidades especiais para resolver crimes arquivados. Ao se juntar ao grupo, ela descobre que o perigo é maior do que imaginava, especialmente quando um novo assassino em série surge."
    },
    {
      "nome": "Jogo Fatal",
      "imagem": "assets/img/livro13.jpg",
      "preco": "R\$ 24,33",
      "descricao": "No prelúdio da série Manual de Assassinato para Boas Garotas, Pip participa de um jogo de investigação com amigos, onde precisa desvendar um crime fictício em uma ilha. Apesar da relutância inicial, ela se envolve na trama e descobre seu talento para investigação — dando início à sua jornada como detetive amadora, enquanto o mistério real de Little Kilton começa a rondar seus pensamentos."
    },
    {
      "nome": "Boa garota, segredo mortal",
      "imagem": "assets/img/livro12.jpg",
      "preco": "R\$ 39,80",
      "descricao": "Na sequência de Manual de Assassinato para Boas Garotas, Pip tenta deixar sua vida de detetive para trás e focar em um podcast sobre seu antigo caso. Mas quando Jamie Reynolds desaparece e a polícia ignora o ocorrido, ela é forçada a investigar novamente. Com a ajuda de amigos e ouvintes, Pip mergulha em um novo mistério sombrio, onde cada segundo é crucial e ninguém é realmente quem parece ser."
    },
    {
      "nome": "Desculpe o exagero, mas não sei sentir pouco",
      "imagem": "assets/img/livro11.jpg",
      "preco": "R\$ 36,93",
      "descricao": "No amor, não há espaço para o raso. Ele não existe na superfície ou mesmo na escassez. Amor é para quem tem coragem de se atirar na intensidade e se esbaldar na abundância. Então, nem perca tempo em ficar onde seus pés alcançam. É no profundo que ele acontece."
    },
    {
      "nome": "Textos cruéis demais para serem lidos rapidamente",
      "imagem": "assets/img/livro10.jpg",
      "preco": "R\$ 41,31",
      "descricao": "O livro Textos cruéis demais para serem lidos rapidamente reúne escritos inéditos do coletivo TCD, conhecidos por suas publicações poéticas e profundas nas redes sociais. Indo na contramão da comunicação rápida e superficial, a obra convida à reflexão sobre as complexas relações humanas, acompanhada por delicadas ilustrações de Anália Moraes."
    },
    {
      "nome": "Textos para tocar cicatrizes",
      "imagem": "assets/img/livro09.jpg",
      "preco": "R\$ 39,80",
      "descricao": "Com mais de 1 milhão de exemplares vendidos, Igor Pires lança sua mais nova obra, Textos para tocar cicatrizes, em que se debruça nos sentimentos que perpassam os relacionamentos e faz reflexões sobre sociedade, luto e família. Nesta coletânea de textos poéticos inéditos, Igor mostra a importância de honrar as cicatrizes que adquirimos com nossas experiências e que elas são responsáveis pelas histórias que contamos."
    },
    {
      "nome": "Poesias que escrevi enquanto aprendia a viver",
      "imagem": "assets/img/livro08.jpg",
      "preco": "R\$ 46,90",
      "descricao": "O livro Poesias que escrevi enquanto aprendia a viver, de Fagner Mera, reúne versos sensíveis que retratam o processo de amadurecimento emocional. Com linguagem acessível e profunda, o autor aborda temas como amor, dor, saudade e autoconhecimento, revelando os sentimentos vividos enquanto aprendia a lidar com a vida."
    },
    {
      "nome": "A Bíblia sagrada",
      "imagem": "assets/img/livro07.jpg",
      "preco": "R\$ 33,75",
      "descricao": "A Bíblia Clássica capa dura da Thomas Nelson Brasil é moderna, versátil e ideal para evangelismo ou presentear grupos. Com miolo econômico e linguagem NVI, oferece uma tradução fiel, clara e contemporânea, unindo qualidade e estilo."
    },
    {
      "nome": "Cristianismo puro e simples",
      "imagem": "assets/img/livro06.jpg",
      "preco": "R\$ 37,44",
      "descricao": "Cristianismo Puro e Simples, de C.S. Lewis, nasceu de palestras transmitidas pela BBC durante a Segunda Guerra Mundial, com o objetivo de explicar de forma clara os fundamentos da fé cristã. Na obra mais acessível de seu legado, Lewis conduz o leitor dos princípios básicos da cosmovisão cristã a reflexões profundas, em um texto que continua relevante e inspirador mais de 70 anos depois."
    },
    {
      "nome": "Tomar um livro e ler um café",
      "imagem": "assets/img/livro04.jpg",
      "preco": "R\$ 46,90",
      "descricao": "Abordando de maneira metafórica e poética, de forma simples, questões complexas como amor, desamor, felicidade, autocuidado, autoconhecimento e tantos outros sentimentos humanos, permitindo que o leitor pare por um momento, e experimente uma introspecção em sua própria realidade"
    },
    {
      "nome": "Todas as flores que não te enviei",
      "imagem": "assets/img/livro05.jpg",
      "preco": "R\$ 34,10",
      "descricao": "Todas as flores que não te enviei trata de sentimentos, inclusive aqueles que lutamos para esconder, mas que estão ali, esperando o momento exato para serem libertos. A inspiração dos poemas de Felipe Rocha chega através da sua imaginação e da sensibilidade, e também da percepção de tudo que está ao seu redor. Foi depois de muita reflexão que, em 2016, nasceu o tipobilhete, como forma de trazer um pouco de alegria para o dia a dia e transbordar aquilo que atitudes não são capazes de demonstrar."
    },
    {
      "nome": "Como se tornar um cristão inútil",
      "imagem": "assets/img/livro02.jpg",
      "preco": "R\$ 29,61",
      "descricao": "O convite ao discipulado e à vida cristã não é um chamado para ser o protagonista da história, mas para ser parte de um povo. Deus não procura quem sonha com cargos e títulos ou quem deseja receber medalhas. Ele está à procura de verdadeiros adoradores, de cristãos comuns que testemunham do evangelho sem precisar subir no palco. Afinal, no reino dos céus não há lugar para especiais, orgulhosos, para quem quer ser o primeiro, mas para gente arrependida e para cristãos “inúteis”!"
    },
    {
      "nome": "O verão que mudou minha vida",
      "imagem": "assets/img/livro01.jpg",
      "preco": "R\$ 41,90",
      "descricao": "A Trilogia Verão, de Jenny Han, acompanha Belly dos 15 aos 24 anos, explorando seus amores, dilemas e amadurecimento. Todo verão, ela vai para Cousins Beach, onde vive momentos marcantes com Conrad e Jeremiah, filhos da melhor amiga de sua mãe. Envolvida em um triângulo amoroso e descobertas pessoais, Belly aprende que crescer também significa fazer escolhas difíceis. A série inspirou a adaptação O Verão que Mudou Minha Vida, do Amazon Prime Video."
    },
    {
      "nome": "Manual de assassinato para boas garotas",
      "imagem": "assets/img/livro03.jpg",
      "preco": "R\$ 38,72",
      "descricao": "Em Manual de Assassinato para Boas Garotas, Pip decide investigar um antigo crime em sua cidade como projeto escolar: o assassinato de Andie Bell, supostamente cometido por Sal Singh, que se suicidou após o ocorrido. Desconfiada da versão oficial, ela mergulha em uma investigação cheia de segredos e perigos, determinada a descobrir a verdade — mesmo que isso coloque sua vida em risco."
    },
  ];

  List<Map<String, String>> livrosFiltrados = [];

  @override
  void initState() { // iniciar variáveis, configurar controladores, carregar dados ou preparar estados iniciais
    super.initState();
    getAPI();
    livrosFiltrados = List.from(todosLivros);
  }

  void getAPI() async {
    final response = await http.get(Uri.parse(""));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // transforma json em string

      setState(() {
        API = data[1]["title"];
      });
    }
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
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: Scaffold( // separa as telas
        backgroundColor: Color.fromRGBO(233, 233, 233, 1),
        appBar: AppBar( // barra superior
          title: Text(
            "AriBooks",
            style: GoogleFonts.zenDots(),
          ),
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
                ],
              ),  
            ), 
          ), 
      ),
    );
  }
}