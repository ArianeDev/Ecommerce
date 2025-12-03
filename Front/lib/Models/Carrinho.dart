import 'package:arianeapp1/Models/Livro.dart';

class ItemCarrinho {
  Livro livro;
  int quantidade;

  ItemCarrinho({
    required this.livro,
    required this.quantidade,
  });
}

class Carrinho {
  final List<ItemCarrinho> itens = [];

  void adicionar(ItemCarrinho livro) {
    final index = itens.indexWhere((item) => item.livro.titulo == livro.livro.titulo);
    if (index >= 0) {
      itens[index].quantidade++;
    } else {
      itens.add(ItemCarrinho(livro: livro.livro, quantidade: livro.quantidade));
    }
  }

  void atualizarQuantidade(Livro livro, int quantidade) {
    final index = itens.indexWhere((item) => item.livro.titulo == livro.titulo);
    if (index >= 0) {
      itens[index].quantidade = quantidade;
    }
  }

  double get total {
    return itens.fold(0, (soma, item) {
      String preco = item.livro.preco.replaceAll("R\$", "").trim();
      preco = preco.replaceAll(",", ".");
      return soma + (double.parse(preco) * item.quantidade);
    }); 
  }
  
  void limpar() {
    itens.clear(); // remove todos os itens
  }
}