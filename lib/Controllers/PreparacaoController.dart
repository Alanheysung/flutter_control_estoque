import 'package:collection/collection.dart';
import '../Models/PreparacaoModel.dart';

class PreparacaoController {
  final List<Preparacao> _preparacoes = [];

  /// Adiciona uma nova preparação, evitando duplicados pelo nome
  bool adicionarPreparacao(Preparacao preparacao) {
    if (_preparacoes.any((p) => p.nome == preparacao.nome)) {
      return false; // Já existe
    }
    _preparacoes.add(preparacao);
    return true;
  }

  /// Remove uma preparação pelo nome
  bool removerPreparacao(String nome) {
  final quantidadeAntes = _preparacoes.length;
  _preparacoes.removeWhere((p) => p.nome == nome);
  return _preparacoes.length < quantidadeAntes;
}


  /// Atualiza uma preparação existente pelo nome
  bool atualizarPreparacao(String nome, Preparacao novaPreparacao) {
    for (var i = 0; i < _preparacoes.length; i++) {
      if (_preparacoes[i].nome == nome) {
        _preparacoes[i] = novaPreparacao;
        return true;
      }
    }
    return false;
  }

  /// Busca uma preparação pelo nome
  Preparacao? buscarPreparacao(String nome) {
    return _preparacoes.firstWhereOrNull((p) => p.nome == nome);
  }

  /// Lista todas as preparações (imutável para fora)
  List<Preparacao> listarPreparacoes() => List.unmodifiable(_preparacoes);

  /// Filtra preparações por grupo
  List<Preparacao> filtrarPorGrupo(String grupo) {
    return _preparacoes.where((p) => p.grupo == grupo).toList();
  }

  /// Filtra preparações por item
  List<Preparacao> filtrarPorItem(String item) {
    return _preparacoes.where((p) => p.item == item).toList();
  }

  /// Limpa todas as preparações
  void limparPreparacoes() {
    _preparacoes.clear();
  }
}
