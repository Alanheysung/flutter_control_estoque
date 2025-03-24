import '../Models/CardapioModel.dart';

class CardapioController {
  final List<Cardapio> _cardapios = [];

  // Adicionar um novo cardápio
  void adicionarCardapio(Cardapio cardapio) {
    _cardapios.add(cardapio);
  }

  // Remover um cardápio pelo nome (pode ajustar conforme o identificador que você desejar)
  void removerCardapio(String nome) {
    _cardapios.removeWhere((cardapio) => cardapio.nome == nome);
  }

  // Atualizar um cardápio existente
  void atualizarCardapio(String nome, Cardapio novoCardapio) {
    for (int i = 0; i < _cardapios.length; i++) {
      if (_cardapios[i].nome == nome) {
        _cardapios[i] = novoCardapio;
        break;
      }
    }
  }

  // Buscar um cardápio pelo nome
  Cardapio? buscarCardapio(String nome) {
    return _cardapios.firstWhere(
      (cardapio) => cardapio.nome == nome,
      //orElse: () => null,
    );
  }

  // Listar todos os cardápios
  List<Cardapio> listarCardapios() {
    return _cardapios;
  }

  // Filtrar por escola
  List<Cardapio> filtrarPorEscola(String escola) {
    return _cardapios.where((c) => c.escola == escola).toList();
  }

  // Filtrar por tipo de refeição
  List<Cardapio> filtrarPorTipoRefeicao(String tipoRefeicao) {
    return _cardapios.where((c) => c.tipoRefeicao == tipoRefeicao).toList();
  }

  // Limpar todos os cardápios
  void limparCardapios() {
    _cardapios.clear();
  }
}
