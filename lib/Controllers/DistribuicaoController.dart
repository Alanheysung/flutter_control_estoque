import '../Models/DistribuicaoModel.dart';
import '../Models/ProdutoModel.dart';

class DistribuicaoController {
  List<Distribuicao> _distribuicoes = [];

  // Enviar produtos para uma escola
  void distribuirParaEscola(int escolaId, List<Produto> produtos) {
    Distribuicao distribuicao = Distribuicao(
      id: _distribuicoes.length + 1,
      escolaId: escolaId,
      produtosEnviados: produtos,
      dataEnvio: DateTime.now(),
    );

    _distribuicoes.add(distribuicao);
    print("Produtos enviados para a escola ID $escolaId.");
  }

  // Listar distribuições feitas
  List<Distribuicao> listarDistribuicoes() {
    return _distribuicoes;
  }
}
