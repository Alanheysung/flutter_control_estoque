import 'package:collection/collection.dart';
import '../Models/ReferenciasNutricionaisModel.dart';

class ReferenciasNutricionaisController {
  final List<ReferenciasNutricionais> _referencias = [];

  /// Adiciona uma nova referência nutricional, evitando duplicidade pelo nome
  bool adicionarReferencia(ReferenciasNutricionais referencia) {
    if (_referencias.any((r) => r.nome == referencia.nome)) {
      return false; // Já existe uma com o mesmo nome
    }
    _referencias.add(referencia);
    return true;
  }

  /// Remove uma referência pelo nome
  bool removerReferencia(String nome) {
    final existe = _referencias.any((r) => r.nome == nome);
    if (existe) {
      _referencias.removeWhere((r) => r.nome == nome);
      return true;
    }
    return false;
  }

  /// Atualiza uma referência existente pelo nome
  bool atualizarReferencia(String nome, ReferenciasNutricionais novaReferencia) {
    for (var i = 0; i < _referencias.length; i++) {
      if (_referencias[i].nome == nome) {
        _referencias[i] = novaReferencia;
        return true;
      }
    }
    return false;
  }

  /// Busca uma referência pelo nome
  ReferenciasNutricionais? buscarReferencia(String nome) {
    return _referencias.firstWhereOrNull((r) => r.nome == nome);
  }

  /// Lista todas as referências nutricionais
  List<ReferenciasNutricionais> listarReferencias() => List.unmodifiable(_referencias);

  /// Filtra referências por categoria de ensino
  List<ReferenciasNutricionais> filtrarPorCategoriaEnsino(String categoria) {
    return _referencias.where((r) => r.categoriaEnsino == categoria).toList();
  }

  /// Filtra por faixa etária
  List<ReferenciasNutricionais> filtrarPorFaixaIdade(int faixa) {
    return _referencias.where((r) => r.faixaIdade == faixa).toList();
  }

  /// Filtra por período (manhã, tarde, integral, etc)
  List<ReferenciasNutricionais> filtrarPorPeriodo(String periodo) {
    return _referencias.where((r) => r.periodo == periodo).toList();
  }

  /// Limpa todas as referências
  void limparReferencias() {
    _referencias.clear();
  }
}
