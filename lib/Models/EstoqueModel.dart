import 'ProdutoModel.dart';

class Estoque {
  final int id;
  final List<Produto> produtos;
  final DateTime dataUltimaAtualizacao;

  Estoque({
    required this.id,
    required this.produtos,
    required this.dataUltimaAtualizacao,
  });

  // Conversão para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'produtos': produtos.map((p) => p.toJson()).toList(),
      'dataUltimaAtualizacao': dataUltimaAtualizacao.toIso8601String(),
    };
  }

  // Criação a partir de JSON
  factory Estoque.fromJson(Map<String, dynamic> json) {
    return Estoque(
      id: json['id'],
      produtos: (json['produtos'] as List)
          .map((item) => Produto.fromJson(item))
          .toList(),
      dataUltimaAtualizacao: DateTime.parse(json['dataUltimaAtualizacao']),
    );
  }
}
