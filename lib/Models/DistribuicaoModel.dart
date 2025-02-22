import 'ProdutoModel.dart';

class Distribuicao {
  final int id;
  final int escolaId;
  final List<Produto> produtosEnviados;
  final DateTime dataEnvio;

  Distribuicao({
    required this.id,
    required this.escolaId,
    required this.produtosEnviados,
    required this.dataEnvio,
  });

  // Conversão para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'escolaId': escolaId,
      'produtosEnviados': produtosEnviados.map((p) => p.toJson()).toList(),
      'dataEnvio': dataEnvio.toIso8601String(),
    };
  }

  // Criação a partir de JSON
  factory Distribuicao.fromJson(Map<String, dynamic> json) {
    return Distribuicao(
      id: json['id'],
      escolaId: json['escolaId'],
      produtosEnviados: (json['produtosEnviados'] as List)
          .map((item) => Produto.fromJson(item))
          .toList(),
      dataEnvio: DateTime.parse(json['dataEnvio']),
    );
  }
}
