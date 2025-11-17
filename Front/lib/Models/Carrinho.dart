import 'package:arianeapp1/Models/Livro.dart';

class itemCarrinho {
  final Livro livro;
  final int quantidade;

  itemCarrinho({
    required this.livro,
    required this.quantidade,
  });
}

class Carrinho {
  final List<itemCarrinho> itens = [];

  void adicionar(Livro livro) {
    final index = itens.indexWhere((item) => item.livro.titulo == livro.titulo);
    if (index >= 0) {
      itens[index].quantidade++;
    } else {
      itens.add(itemCarrinho(livro: livro, quantidade: 1));
    }
  }
}