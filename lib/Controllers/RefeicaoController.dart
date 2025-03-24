import 'package:collection/collection.dart';
import '../Models/RefeicaoModel.dart';

class RefeicaoController {
  final List<Refeicao> _refeicoes = [];

  /// Adiciona uma nova refeição, evitando duplicados pelo nome
  bool adicionarRefeicao(Refeicao refeicao) {
    if (_refeicoes.any((r) => r.nome == refeicao.nome)) {
      return false; // Já existe uma com o mesmo nome
    }
    _refeicoes.add(refeicao);
    return true;
  }

  /// Remove uma refeição pelo nome
  bool removerRefeicao(String nome) {
    final existe = _refeicoes.any((r) => r.nome == nome);
    if (existe) {
      _refeicoes.removeWhere((r) => r.nome == nome);
      return true;
    }
    return false;
  }

  /// Atualiza uma refeição existente pelo nome
  bool atualizarRefeicao(String nome, Refeicao novaRefeicao) {
    for (var i = 0; i < _refeicoes.length; i++) {
      if (_refeicoes[i].nome == nome) {
        _refeicoes[i] = novaRefeicao;
        return true;
      }
    }
    return false;
  }

  /// Busca uma refeição pelo nome
  Refeicao? buscarRefeicao(String nome) {
    return _refeicoes.firstWhereOrNull((r) => r.nome == nome);
  }

  /// Lista todas as refeições
  List<Refeicao> listarRefeicoes() => List.unmodifiable(_refeicoes);

  /// Filtra refeições por descrição
  List<Refeicao> filtrarPorDescricao(String descricao) {
    return _refeicoes.where((r) => r.descricao.contains(descricao)).toList();
  }

  /// Filtra refeições por data específica
  List<Refeicao> filtrarPorData(DateTime data) {
    return _refeicoes.where((r) =>
      r.horario.year == data.year &&
      r.horario.month == data.month &&
      r.horario.day == data.day
    ).toList();
  }

  /// Limpa todas as refeições
  void limparRefeicoes() {
    _refeicoes.clear();
  }
}
