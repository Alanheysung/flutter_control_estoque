import '../Models/ProdutoModel.dart';

class ProdutoController {
  List<Produto> _produtos = [];

  // Adicionar um novo produto
  void adicionarProduto(Produto produto) {
    _produtos.add(produto);
    print("Produto '${produto.nome}' adicionado com sucesso!");
  }

  // Atualizar um produto pelo ID
  void atualizarProduto(int id, Produto novoProduto) {
    int index = _produtos.indexWhere((produto) => produto.id == id);
    if (index != -1) {
      _produtos[index] = novoProduto;
      print("Produto atualizado com sucesso!");
    } else {
      print("Produto não encontrado!");
    }
  }

  // Remover um produto pelo ID
  void removerProduto(int id) {
    _produtos.removeWhere((produto) => produto.id == id);
    print("Produto removido com sucesso!");
  }

  // Listar todos os produtos
  List<Produto> listarProdutos() {
    return _produtos;
  }
}
