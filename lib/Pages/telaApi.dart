import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiAll extends StatefulWidget {
  const ApiAll({super.key});

  @override
  State<ApiAll> createState() => _ApiAllState();
}

class _ApiAllState extends State<ApiAll> {
  List<dynamic>? valor;

  @override
  void initState() {
    super.initState();
    getAPI();
  }

  void getAPI() async {
    final response = await http.get(Uri.parse("https://swapi.dev/api/people"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // transforma json em string

      setState(() {
        valor = data["results"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: valor == null ? Center(child: CircularProgressIndicator()) :
        Center(
          child: ListView.builder(
            itemCount: valor!.length, // quantos itens
            itemBuilder: (context, index) {
              final item = valor![index]; // criar variavel item para cada index
              return Container(
                width: 150,
                height: 150,
                color: Colors.blue,
                child: Text("${item["name"]}"),
              );
            }, // o que vai construir
          ),
        )    
      ),
    );
  }
}