import 'package:collection/collection.dart';
import '../Models/EscolaModel.dart';

class EscolaController {
  final List<Escola> _escolas = [];

  /// Adiciona uma escola, evitando duplicadas pelo ID
  bool adicionarEscola(Escola escola) {
    if (_escolas.any((e) => e.id == escola.id)) {
      return false; // ID já existente
    }
    _escolas.add(escola);
    return true;
  }

  /*/// Remove escola pelo ID
  bool removerEscola(int id) {
    return _escolas.removeWhere((e) => e.id == id) > 0;
  }
  */
  /// Atualiza dados de uma escola pelo ID
  bool atualizarEscola(int id, Escola novaEscola) {
    for (var i = 0; i < _escolas.length; i++) {
      if (_escolas[i].id == id) {
        _escolas[i] = novaEscola;
        return true;
      }
    }
    return false;
  }

  /// Busca escola pelo ID
  Escola? buscarEscolaPorId(int id) {
    return _escolas.firstWhereOrNull((e) => e.id == id);
  }

  /// Busca escola pelo nome
  Escola? buscarEscolaPorNome(String nome) {
    return _escolas.firstWhereOrNull((e) => e.nome == nome);
  }

  /// Lista todas as escolas
  List<Escola> listarEscolas() => List.unmodifiable(_escolas);

  /// Filtrar escolas por modalidade
  List<Escola> filtrarPorModalidade(String modalidade) {
    return _escolas.where((e) => e.modalidade == modalidade).toList();
  }

  /// Filtrar escolas por faixa etária
  List<Escola> filtrarPorFaixaIdade(int faixaIdade) {
    return _escolas.where((e) => e.faixaIdade == faixaIdade).toList();
  }

  /// Limpa todas as escolas
  void limparEscolas() {
    _escolas.clear();
  }
}
