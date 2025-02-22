import '../Models/EstoqueModel.dart';
import '../Models/ProdutoModel.dart';

class EstoqueController {
  Estoque _estoque = Estoque(id: 1, produtos: [], dataUltimaAtualizacao: DateTime.now());

  // Adicionar produto ao estoque
  void adicionarAoEstoque(Produto produto) {
    _estoque.produtos.add(produto);
    _estoque = Estoque(
      id: _estoque.id,
      produtos: _estoque.produtos,
      dataUltimaAtualizacao: DateTime.now(),
    );
    print("Produto '${produto.nome}' adicionado ao estoque!");
  }

  // Remover produto do estoque pelo ID
  void removerDoEstoque(int produtoId) {
    _estoque.produtos.removeWhere((produto) => produto.id == produtoId);
    _estoque = Estoque(
      id: _estoque.id,
      produtos: _estoque.produtos,
      dataUltimaAtualizacao: DateTime.now(),
    );
    print("Produto removido do estoque!");
  }

  // Listar produtos no estoque
  List<Produto> listarEstoque() {
    return _estoque.produtos;
  }
}
