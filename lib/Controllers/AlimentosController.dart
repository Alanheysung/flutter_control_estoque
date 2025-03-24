import 'package:collection/collection.dart';
import '../Models/AlimentosModel.dart';

class AlimentosController {
  final List<Alimentos> _alimentos = [];

  /// Adiciona um novo alimento, evitando duplicidade pelo nome
  bool adicionarAlimento(Alimentos alimento) {
    if (_alimentos.any((a) => a.nome == alimento.nome)) {
      return false; // Já existe com o mesmo nome
    }
    _alimentos.add(alimento);
    return true;
  }

  /// Remove alimento pelo nome
  bool removerAlimento(String nome) {
    final existe = _alimentos.any((a) => a.nome == nome);
    if (existe) {
      _alimentos.removeWhere((a) => a.nome == nome);
      return true;
    }
    return false;
  }

  /// Atualiza alimento pelo nome
  bool atualizarAlimento(String nome, Alimentos novoAlimento) {
    for (var i = 0; i < _alimentos.length; i++) {
      if (_alimentos[i].nome == nome) {
        _alimentos[i] = novoAlimento;
        return true;
      }
    }
    return false;
  }

  /// Buscar alimento pelo nome
  Alimentos? buscarAlimento(String nome) {
    return _alimentos.firstWhereOrNull((a) => a.nome == nome);
  }

  /// Lista todos os alimentos
  List<Alimentos> listarAlimentos() => List.unmodifiable(_alimentos);

  /// Filtrar alimentos por grupo
  List<Alimentos> filtrarPorGrupo(String grupo) {
    return _alimentos.where((a) => a.grupo == grupo).toList();
  }

  /// Filtrar alimentos por preço máximo
  List<Alimentos> filtrarPorPrecoMaximo(double precoMaximo) {
    return _alimentos.where((a) => a.preco <= precoMaximo).toList();
  }

  /// Filtrar alimentos por faixa de preço
  List<Alimentos> filtrarPorFaixaPreco(double precoMin, double precoMax) {
    return _alimentos.where((a) => a.preco >= precoMin && a.preco <= precoMax).toList();
  }

  /// Limpa todos os alimentos
  void limparAlimentos() {
    _alimentos.clear();
  }
}
